class Like < ActiveRecord::Base
  has_one :notification
  belongs_to :like
  belongs_to :user
  attr_accessible :target_object, :target_object_id, :user_id
end
