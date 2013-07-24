class Like < ActiveRecord::Base
  has_one :event
  attr_accessible :target_object, :target_object_id, :user_id, :event_id
end
