class Event < ActiveRecord::Base
  belongs_to :like
  belongs_to :comment
  belongs_to :user

  attr_accessible :comment_id, :like_id, :event_type, :user_id
end
