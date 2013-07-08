class HopTask < ActiveRecord::Base
  belongs_to :hop

  belongs_to :user
  attr_accessible :hop_task_price, :amt,:hop_tasks, :bonus, :pts, :sponsor_id, :text_for_hop, :hop_picture, :hop_id, :sponsor_name
  has_attached_file :hop_picture,
                    :url  => "/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension"


  validates :bonus, :pts,    numericality: { only_integer: true }
  validates  :sponsor_name, length: { minimum: 5}, if: :daily_hop?
  validates :text_for_hop, length: { minimum: 5, maximum:140 }
  validates :hop_task_price,:amt,  numericality: { only_integer: true }, if: :daily_hop?


  def daily_hop?
   hop.daily_hop.class == FalseClass
  end

end
