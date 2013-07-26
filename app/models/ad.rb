class Ad < ActiveRecord::Base
  belongs_to :hop
  belongs_to :advertizer, foreign_key: 'advertizer_id', class_name: 'User'

  attr_accessible :advertizer_id,
                  :hop_id,
                  :ad_type,
                  :price,
                  :amt_paid,
                  :link,
                  :picture

  has_attached_file :picture,
    :url  => "/images/ad_pictures/ads/:id/AD_PICTURE.:extension",
    :default_url => "/assets/no_ad_picture.png",
    :path => ":rails_root/public/images/ad_pictures/ads/:id/AD_PICTURE.:extension"

  validates :price, :amt_paid, numericality: { only_integer: true }
  validates_presence_of :ad_type, :link

  def self.types
    ['type1', 'type2', 'typ23']
  end

end