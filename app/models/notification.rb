class Notification < ActiveRecord::Base
  belongs_to :like
  belongs_to :comment
  belongs_to :user
  belongs_to :prize
  belongs_to :message
  belongs_to :hop
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  attr_accessible :comment_id, :like_id, :event_type, :user_id, :prize_id, :friend_id, :message_id, :hop_id
  validate :is_enabled
  before_create :push

  private

  def is_enabled
    if user && user.user_settings
      case event_type
        when "Friend invite"
          unless user.user_settings.friend_invite
            errors.add(:id, "disabled.")
          end
        when "Comment"
          unless user.user_settings.comment_or_like
            errors.add(:id, "disabled.")
          end
        when "Like"
          unless user.user_settings.comment_or_like
            errors.add(:id, "disabled.")
          end
        when "Message"
          unless user.user_settings.message
            errors.add(:id, "disabled.")
          end
        when "New hop"
          unless user.user_settings.new_hop
            errors.add(:id, "disabled.")
          end
        when "Hop about to end"
          unless user.user_settings.hop_about_to_end
            errors.add(:id, "disabled.")
          end
      end
    end
  end

  def push
    require 'rest-client'
    #user_sessions = CashHoppers::Application::SESSIONS.select{|session|
    #  session if session[:user_id] == user_id
    #}
    user_sessions = Session.where(:user_id => user_id)

    puts "-------------------------------#{user_sessions}----------------------------------"
    puts "-------------------------------#{user_sessions}----------------------------------"
    puts "-------------------------------#{user_sessions}----------------------------------"
    text = ""
    case event_type
      when "Friend invite"
        text = "#{friend.first_name if friend} would like to be your friend."
      when "Comment"
        text = "#{comment.user.first_name if( comment && comment.user)} commented your photo."
      when "Like"
        text = "#{like.user.first_name if(like && like.user)} liked your photo."
      when "Message"
        text = "#{message.sender.first_name if(message && message.sender)}: #{ message.text if message}"
      when "New hop"
        text = "Hop '#{hop.name if hop}' created."
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
          'registration_ids' => [session[:device_token]],
          data: {
            'message' => text
          }
        }
        response = RestClient.post(url, request.to_json, headers)
        response_hash = YAML.load(response)
        AndroidLog.create text: response_hash
      end
    end
  end

end