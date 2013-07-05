class HopTask < ActiveRecord::Base
  belongs_to :hop

  belongs_to :user
  attr_accessible :hop_task_price,:hop_tasks, :bonus, :pts, :sponsor_id, :text_for_hop, :hop_picture, :hop_id, :sponsor_name
  has_attached_file :hop_picture,
                    :url  => "/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension"


 # validates_presence_of
#  validates :contact_phone, :producer_contact, length: { minimum: 5}, if: :daily_hop?
  validates :text_for_hop, length: { minimum: 10, maximum:140 }



  def daily_hop?
   hop.daily_hop.class == FalseClass
  end

end
