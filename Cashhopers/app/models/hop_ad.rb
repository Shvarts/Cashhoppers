class HopAd < ActiveRecord::Base
  belongs_to :hop
  attr_accessible :ad_name, :contact, :email, :phone, :hop_ad_type, :price, :sponsor_id, :hop_id
end