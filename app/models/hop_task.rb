class HopTask < ActiveRecord::Base
  belongs_to :hop

  belongs_to :user
  attr_accessible :hop_task_price,:hop_tasks, :bonus, :pts, :sponsor_id, :text_for_hop, :hop_picture, :hop_id, :sponsor_name
  has_attached_file :hop_picture,
                    :url  => "/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension"
end
