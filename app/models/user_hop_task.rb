class UserHopTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :hop_task

  has_attached_file :photo,
                    :url  => "/images/user_hop_task_photos/tasks/:id/:style/PHOTO.:extension",
                    :default_url => "/images/noavatar.jpeg",
                    :path => ":rails_root/public/images/user_hop_task_photos/tasks/:id/:style/PHOTO.:extension"

  attr_accessible :user_id, :hop_task_id, :photo, :comment
end
