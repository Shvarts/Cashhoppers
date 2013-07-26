class Hop < ActiveRecord::Base
  has_and_belongs_to_many :hoppers, :join_table =>"hoppers_hops" , :class_name=>"User"

  has_many :hop_tasks,  :dependent => :destroy
  has_many :prizes
  has_many :ads,  :dependent => :destroy
  belongs_to :producer, :class_name => 'User'
  has_attached_file :logo,
                    :url  => "/images/hop_logos/hops/:id/HOP_LOGO.:extension",
                    :default_url => "/assets/no_hop_logo.png",
                    :path => ":rails_root/public/images/hop_logos/hops/:id/HOP_LOGO.:extension"

  attr_accessible :close, :event, :daily, :code, :price, :jackpot, :name, :producer_id, :time_end, :time_start, :logo

  validates_presence_of :time_start, :name
  validates_presence_of :time_end, :jackpot,  :producer_id, unless: :daily?
  validates :jackpot, numericality: { only_integer: true }, unless: :daily?
  validates :price, numericality: true, unless: :daily?

  def assign user
    unless hoppers.include? user
      hoppers << user
      ActiveRecord::Base.connection().execute("UPDATE hoppers_hops SET pts = 0 WHERE user_id = #{user.id} AND hop_id = #{id}")
    end
  end

  def score user
    hoppers_hops = ActiveRecord::Base.connection.select_all("SELECT pts FROM hoppers_hops WHERE user_id = #{user.id} AND hop_id = #{id} LIMIT 1")
    if hoppers_hops.length == 0
      0
    else
      hoppers_hops[0]['pts']
    end
  end

  def increase_score user, pts
    current_pts = self.score user
    ActiveRecord::Base.connection().execute("UPDATE hoppers_hops SET pts = #{current_pts + pts} WHERE user_id = #{user.id} AND hop_id = #{id}")
  end

  def self.create_prize(hop, place, prize)

    for i in 0 ...prize.count  do
      hop.prizes.create!(:jackpot => prize[i.to_s], :place => place[i.to_s], :hop_name => hop.name)

    end


  end
end