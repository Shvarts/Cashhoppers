class HopTask < ActiveRecord::Base
  has_many :user_hop_tasks
  belongs_to :hop
  belongs_to :sponsor, class_name: 'User', foreign_key: :sponsor_id

  attr_accessible :price, :amt, :bonus, :pts, :sponsor_id, :text, :hop_id

  validates :bonus, :pts, numericality: { only_integer: true }
  validates :text, length: { minimum: 5, maximum:140 }
  validates :price, :amt,  numericality: { only_integer: true }, if: :not_daily?


  def not_daily?
    !hop.daily
  end

end
