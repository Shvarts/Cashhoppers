class HopAd < ActiveRecord::Base
  belongs_to :hop
  attr_accessible :ad_name, :contact, :email, :phone, :ad_type, :price, :sponsor_id, :hop_id, :link_to_ad, :hop_ad_picture
  has_attached_file :hop_ad_picture,
                    :url  => "/images/ad_pictures/hop_ad/:id/AD_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/hop_ad/:id/AD_PICTURE.:extension"

end
