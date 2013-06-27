class Ad < ActiveRecord::Base
  attr_accessible :advert_id, :advertiser_name, :amd_paid, :picture, :contact, :email, :hop_id, :phone, :price, :type_add
  has_attached_file :picture
end
