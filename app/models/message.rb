include ActionView::Helpers::DateHelper

class Message < ActiveRecord::Base

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_many :notifications

  attr_accessible :receiver_id, :sender_id, :schedule_date, :synchronized, :text

  validates :text, presence: true

  after_create :push_to_thread
  before_create :set_synchronized

  def self.thread user, page = nil, per_page = nil
    pagination = ""
    if page && per_page
      pagination = "LIMIT #{per_page} OFFSET #{page.to_i - 1}"
    end
    thread = ActiveRecord::Base.connection.select_all(
      "SELECT messages.id, messages.text, messages.created_at, messages.sender_id, messages.receiver_id,
        IF(sender.id = #{user.id}, receiver.id, sender.id) AS friend_id,
        IF(sender.id = #{user.id}, receiver.first_name, sender.first_name) AS friend_first_name,
        IF(sender.id = #{user.id}, receiver.last_name, sender.last_name) AS friend_last_name,
        IF(sender.id = #{user.id}, receiver.user_name, sender.user_name) AS friend_user_name,
        IF(sender.id = #{user.id}, receiver.avatar_file_name, sender.avatar_file_name) AS friend_avatar_file_name

      FROM messages
      LEFT JOIN users AS sender ON  messages.sender_id = sender.id
      LEFT JOIN users AS receiver ON  messages.receiver_id = receiver.id

      WHERE messages.created_at IN (
        SELECT last_message.max_val FROM(
          SELECT MAX( messages.created_at ) AS max_val, IF( messages.sender_id = #{user.id}, messages.receiver_id, messages.sender_id ) AS friend
          FROM messages WHERE messages.receiver_id = #{user.id} OR messages.sender_id = #{user.id} GROUP BY friend
        ) AS last_message
      )

      ORDER BY messages.created_at DESC
      #{pagination};"
    )
    ActiveRecord::Base.connection.close
    thread
  end

  def push_to_thread
    CashHoppers::Application::MESSAGES << self
    Notification.create(user_id: receiver.id, friend_id: sender.id, event_type: 'Message', message_id: id)
  end

  def to_json current_user
    friendship = nil
    if sender_id == current_user.id
      friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, receiver_id)
    else
      friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, sender_id)
    end

    {
      sender_id:   sender_id,
      receiver_id: receiver_id,
      text:        text,
      created_at:  created_at,
      time_ago:    time_ago_in_words(created_at),
      friendship_status: friendship.status
    }
  end

  private

  def set_synchronized
    self.synchronized = 0
  end

end