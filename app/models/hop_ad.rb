class HopAd < ActiveRecord::Base
  attr_accessible :ad_name, :contact, :email, :phone, :price, :sponsor_id, :hop_id
end
