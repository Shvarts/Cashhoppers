class Notification < ActiveRecord::Base
  belongs_to :like
  belongs_to :comment
  belongs_to :user
  belongs_to :prize
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  attr_accessible :comment_id, :like_id, :event_type, :user_id, :prize_id, :friend_id
end
