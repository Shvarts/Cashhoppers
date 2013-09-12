class Prize < ActiveRecord::Base
  attr_accessible :cost, :place, :user_id, :hop_id, :prize_type , :accept, :description
  belongs_to :hop
  belongs_to :user
  has_one :notification
  #validates :place, numericality: { only_integer: true }, if: "prize_type.nil?"
  validates_presence_of :cost
end
