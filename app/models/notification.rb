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
          unless user.user_settings.friend_invite
            puts '====fi'
            errors.add(:id, "disabled.")
          end
        when "Friend invite accept"
          unless user.user_settings.friend_invite_accept
            puts '====fia'
            errors.add(:id, "disabled.")
          end
        when "End of hop"
          unless user.user_settings.end_of_hop
            puts '====eoh'
            errors.add(:id, "disabled.")
          end
        when "Comment"
          unless user.user_settings.comment
            puts '====comment'
            errors.add(:id, "disabled.")
          end
        when "Like"
          unless user.user_settings.like
            puts '====like'
            errors.add(:id, "disabled.")
          end
      end
      puts '===='
      puts errors.inspect
      puts '===='

    end
  end

  def push
    require 'rest-client'
    user_sessions = CashHoppers::Application::SESSIONS.select{|session|
      session if session[:user_id] == user_id
    }
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

    user_sessions.each do |session|
      if session && session[:device] == 'IOS'
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
      elsif session && session[:device] == 'Android'
        url = 'https://android.googleapis.com/gcm/send'
        headers = {
          'Authorization' => 'key=AIzaSyBkzAsSd1k-_-1Lg2f_ikkAWvkG2Diwe_w',
          'Content-Type'=> "application/json"
        }
        request = {
          'registration_ids' => ["APA91bEkPHgqTGT_gArNyV7FkKusvuYh0s37B7l8L06bOzc0eIuts8_Gn6V4Pa4ooos87CZrqsXgjKXI4oQDAnB59auSqt40K0O8yqKB8SKILZQOrNYjDvg5cceLCn6ZnPi62-EmYix2Rx2pnzdVzaqVmup1FH_1yz7SSTuUAfU1qmWXvFSk1r4"],
          'message' => 'Hello from Uzhgorod!!!'
        }
        response = RestClient.post(url, request, headers)
        #response_hash = YAML.load(response)
      end
    end
  end

end