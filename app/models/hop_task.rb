class HopTask < ActiveRecord::Base
  has_many :user_hop_tasks
  belongs_to :hop
  belongs_to :sponsor, class_name: 'User', foreign_key: :sponsor_id

  attr_accessible :price, :amt_paid, :bonus, :pts, :sponsor_id, :text, :hop_id

  validates :bonus, :pts, numericality: { only_integer: true }
  validates :text, length: { minimum: 5, maximum:140 }
  validates :price, :amt_paid,  numericality: { only_integer: true }, if: :not_daily?
  validates_presence_of :sponsor_id

  def not_daily?
    if self.hop
      !self.hop.daily
    else
      false
    end
  end

end