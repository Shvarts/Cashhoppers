class Hop < ActiveRecord::Base
  has_many :hop_tasks
  has_many :hop_ads
  belongs_to :user
  belongs_to :daily_hop

  attr_accessible :contact_email, :hop_close, :hop_daily, :contact_phone, :hop_code, :hop_items, :hop_price, :jackpot, :name, :producer_contact, :producer_id, :time_end, :time_start
end
