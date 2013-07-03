class Ad < ActiveRecord::Base


  attr_accessible :advert_id,:link_to_ad, :advertiser_name, :amd_paid, :ad_picture, :contact, :email, :hop_id, :phone, :price, :type_add
  has_attached_file :ad_picture,
    :url  => "/images/ad_pictures/ads/:id/AD_PICTURE.:extension",
    :default_url => "/assets/no_ad_picture.jpg",
    :path => ":rails_root/public/images/ad_pictures/ads/:id/AD_PICTURE.:extension"
end
