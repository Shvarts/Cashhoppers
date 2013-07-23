class Like < ActiveRecord::Base
  attr_accessible :target_object, :target_object_id, :user_id
end
