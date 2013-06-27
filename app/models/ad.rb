class Ad < ActiveRecord::Base
  attr_accessible :advert_id, :advertiser_name, :amd_paid, :contact, :email, :hop_id, :phone, :price, :type_add
end
