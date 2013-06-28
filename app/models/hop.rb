class Hop < ActiveRecord::Base
  has_many :hop_tasks
  belongs_to :user
  attr_accessible :contact_email, :contact_phone, :hop_code, :hop_items, :hop_price, :jackpot, :name, :producer_contact, :producer_id, :time_end, :time_start
end
