class UserHopTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :hop_task
  has_many :comments, foreign_key: 'commentable_id'
  has_many :likes, foreign_key: 'target_object_id'
  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url  => "/images/user_hop_task_photos/tasks/:id/:style/PHOTO.:extension",
                    :default_url => "/assets/no_feed_image.png",
                    :path => ":rails_root/public/images/user_hop_task_photos/tasks/:id/:style/PHOTO.:extension"

  attr_accessible :user_id, :hop_task_id, :photo, :comment, :facebook_shared, :twitter_shared, :google_shared

  before_create :init_values



  private

  def init_values
    self.facebook_shared = 0
    self.twitter_shared = 0
    self.google_shared = 0
  end

end
