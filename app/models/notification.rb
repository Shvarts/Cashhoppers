class Notification < ActiveRecord::Base
  belongs_to :like
  belongs_to :comment
  belongs_to :user
  belongs_to :prize
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  attr_accessible :comment_id, :like_id, :event_type, :user_id, :prize_id, :friend_id

  def push(session)
    session = CashHoppers::Application::SESSIONS.select{|session|
      session if session[:user_id] == user_id
    }.first

    if session[:device] == 'IOS'
      notification = Grocer::Notification.new(
        device_token:      session[:device_token],
        alert:             event_type,
        badge:             42,
        sound:             "siren.aiff",         # optional
        expiry:            0,#,Time.now + 60*60, # optional; 0 is default, meaning the message is not stored
        identifier:        1234,                 # optional
        content_available: true                  # optional; any truthy value will set 'content-available' to 1
      )
      CashHoppers::Application::IOS_PUSHER.push(notification)
    end


  end

end
