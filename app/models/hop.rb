class Hop < ActiveRecord::Base
  has_many :hop_tasks, :dependent => :destroy
  has_many :ads,  :dependent => :destroy
  belongs_to :producer, :class_name => 'User'

  attr_accessible :close, :event, :daily_hop, :code, :price, :jackpot, :name, :producer_id, :time_end, :time_start

  validates_presence_of :time_start, :name

  # get only active for default
  default_scope where(:close => false)
  scope :daily, where('daily_hop = 1 AND DATE(time_start) = CURDATE()')
  scope :daily_all, where(:daily_hop => true )
  scope :regular, where(:daily_hop => false)

  validates_presence_of :code, :time_end, :jackpot,  :producer_id, if: :daily_hop?
  validates :jackpot, numericality: { only_integer: true }, if: :daily_hop?

  validates :price, numericality: true, if: :daily_hop?

  def daily_hop?
    daily_hop.class == FalseClass
  end

end

class String
  def to_bool
    return true if self == true || self =~ (/(true|1|"1")$/i)
    return false if self == false || self.blank? || self =~ (/(false|f|'0'|nil|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
