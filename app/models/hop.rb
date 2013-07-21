class Hop < ActiveRecord::Base

  has_and_belongs_to_many :hoppers, :join_table =>"hoppers_hops" , :class_name=>"User"

  has_many :hop_tasks, :dependent => :destroy
  has_many :ads,  :dependent => :destroy
  belongs_to :producer, :class_name => 'User'

  attr_accessible :close, :event, :daily, :code, :price, :jackpot, :name, :producer_id, :time_end, :time_start

  validates_presence_of :time_start, :name
  validates_presence_of :time_end, :jackpot,  :producer_id, if: :daily?
  validates :jackpot, numericality: { only_integer: true }, if: :daily?
  validates :price, numericality: true, if: :daily?

  def daily
    where('daily = 1 AND DATE(time_start) = CURDATE()')
  end

  def daily_all
    where(:daily => true )
  end

  def regular
    where(:daily => false )
  end

end