class Notification < ActiveRecord::Base
  belongs_to :like
  belongs_to :comment
  belongs_to :user
  belongs_to :prize
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  attr_accessible :comment_id, :like_id, :event_type, :user_id, :prize_id, :friend_id
  validate :is_enabled
  before_create :push

  private

  def is_enabled
    if user && user.user_settings
      case event_type
        when "Friend invite"
          if user.user_settings.friend_invite
            errors.add(:id, "disabled.")
          end
        when "Friend invite accept"
          if user.user_settings.friend_invite_accept
            errors.add(:id, "disabled.")
          end
        when "End of hop"
          if user.user_settings.end_of_hop
            errors.add(:id, "disabled.")
          end
        when "Comment"
          if user.user_settings.comment
            errors.add(:id, "disabled.")
          end
        when "Like"
          if user.user_settings.like
            errors.add(:id, "disabled.")
          end
      end
    end

    if user && user.user_settings
      errors.add(:start_date, "Can be only one daily hop per day.")
    end
  end

  def push
    session = CashHoppers::Application::SESSIONS.select{|session|
      session if session[:user_id] == user_id
    }.first

    if session && session[:device] == 'IOS'

      text = ""
      case event_type
        when "Friend invite"
          text = "#{friend.first_name if friend} would like to be your friend."
        when "Friend invite accept"
          text = "#{friend.first_name if friend} accepted your invite to be friends."
        when "End of hop"
          hop = Hop.where(id: prize.hop_id).first
          text = "Hop #{hop ? hop.name : ''} was ended."
        when "Comment"
          text = "#{comment.user.first_name if( comment && comment.user)} commented your photo."
        when "Like"
          text = "#{like.user.first_name if(like && like.user)} liked your photo."
      end

      text = event_type if text == ""

      notification = Grocer::Notification.new(
        device_token:      session[:device_token],
        alert:             text
        #badge:             42,
        #
        #expiry:            0,#,Time.now + 60*60, # optional; 0 is default, meaning the message is not stored
        #identifier:        1234,                 # optional
        #content_available: true                  # optional; any truthy value will set 'content-available' to 1
      )
      CashHoppers::Application::IOS_PUSHER.push(notification)
    end
  end

end