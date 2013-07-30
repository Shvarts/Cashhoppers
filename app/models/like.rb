class Like < ActiveRecord::Base
  has_one :notification
  attr_accessible :target_object, :target_object_id, :user_id
end
