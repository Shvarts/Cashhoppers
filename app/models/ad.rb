class Ad < ActiveRecord::Base
  belongs_to :hop
  belongs_to :advertizer, foreign_key: 'advertizer_id', class_name: 'User'

  attr_accessible :advertizer_id,
                  :hop_id,
                  :ad_type,
                  :price,
                  :amt_paid,
                  :link,
                  :picture,
                  :creator_id

  has_attached_file :picture,
    :url  => "/images/ad_pictures/ads/:id/AD_PICTURE.:extension",
    :default_url => "/assets/no_ad_picture.png",
    :path => ":rails_root/public/images/ad_pictures/ads/:id/AD_PICTURE.:extension"


  validates_presence_of :ad_type, :link, :advertizer_id,  :picture
  validates :link, format: { with: /^http:\/\/.*\..*/,
                                    message: "only 'http://'" }

  validates :picture, format: { with: /.png|.gif|.jpg/,
                                    message: "only image (.jpg, .png, .gif)" }

  def self.types hop
    if hop == nil
      [['RPOU', 'RPOU'], ['ROTATE CH', 'RCH']]
    elsif hop.daily
      [['SPONSOR FULL PG', 'SP'], ['FULL PG - ROTATE', 'ROFL']]
    else
      [['SPONSOR FULL PG', 'SP'], ['FULL PG - ROTATE', 'ROFL'], ['POP - UP ROTATE', 'ROPU']]
    end
  end

  def self.ads_for_hop hop
    ads = {}
    self.types(hop).each do |type|
      ads[type[1].to_sym] = hop == nil ? where(ad_type: type[1]) : hop.ads.where(ad_type: type[1])
    end
    ads
  end

end