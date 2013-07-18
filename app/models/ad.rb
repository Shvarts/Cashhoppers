class Ad < ActiveRecord::Base
  belongs_to :hop

  attr_accessible :ad_name,
                  :advert_id,
                  :link_to_ad,
                  :ad_name,
                  :amt,
                  :hop_ad_picture,
                  :contact,
                  :email,
                  :hop_id,
                  :phone,
                  :price,
                  :type_add,
                  :sponsor_id,
                  :ad_type

  has_attached_file :hop_ad_picture,
    :url  => "/images/ad_pictures/ads/:id/AD_PICTURE.:extension",
    :default_url => "/assets/no_ad_picture.jpg",
    :path => ":rails_root/public/images/ad_pictures/ads/:id/AD_PICTURE.:extension"


  validates :ad_name,:contact, length: { minimum: 3, maximum:140 }
  validates :price, :phone, :amt, numericality: { only_integer: true }
  validates_presence_of :email, :ad_type, :link_to_ad

  def daily_hop?
    ad.daily_hop.class == FalseClass
  end

end
