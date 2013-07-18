class HopTask < ActiveRecord::Base
  has_many :user_hop_tasks
  belongs_to :hop
  belongs_to :sponsor, class_name: 'User', foreign_key: :sponsor_id

  attr_accessible :price, :amt, :bonus, :pts, :sponsor_id, :text, :hop_picture, :hop_id
  has_attached_file :hop_picture,
                    :url  => "/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/hoptask/:id/AD_PICTURE.:extension"


  validates :bonus, :pts, numericality: { only_integer: true }
  validates :text, length: { minimum: 5, maximum:140 }
  validates :price,:amt,  numericality: { only_integer: true }, if: :daily_hop?


  def daily_hop?
    hop.daily_hop.class == FalseClass if hop
  end

end
