class Hop < ActiveRecord::Base
  has_and_belongs_to_many :hoppers, :join_table =>"hoppers_hops" , :class_name=>"User"

  has_many :hop_tasks, :dependent => :destroy
  has_many :ads,  :dependent => :destroy
  belongs_to :producer, :class_name => 'User'
  has_attached_file :logo,
                    :url  => "/images/hop_logos/hops/:id/HOP_LOGO.:extension",
                    :default_url => "/assets/no_hop_logo.png",
                    :path => ":rails_root/public/images/hop_logos/hops/:id/HOP_LOGO.:extension"
  has_many :prizes
  has_many :notifications

  attr_accessible :close, :event, :daily, :code, :price, :jackpot, :name, :producer_id, :time_end, :time_start, :logo, :notificated_about_end

  validates_presence_of :time_start, :name
  validates_presence_of :time_end, :jackpot,  :producer_id, unless: :daily?
  #validates :jackpot, numericality: { only_integer: true }, unless: :daily?
  validates :price, numericality: { greater_than: 0, allow_blank: true }
  validate :only_one_daily_hop_per_day

  before_create :init_hop
  after_create :push_to_thread

  def push_to_thread
    User.all.each do |user|
      Notification.create(user_id: user.id, friend_id: nil, event_type: 'New hop', hop_id: id)
    end
  end

  def init_hop
    self.notificated_about_end = 0
  end

  def self.get_daily_by_date date
    Hop.where("time_start BETWEEN ? AND ? AND daily = 1", date.beginning_of_day, date.end_of_day).first
  end

  def assign user
    unless hoppers.include? user
      hoppers << User.find(user.id)
      ActiveRecord::Base.connection().execute("UPDATE hoppers_hops SET pts = 0 WHERE user_id = #{user.id} AND hop_id = #{id}")
      ActiveRecord::Base.connection.close
    end
  end

  def assigned? user
    hoppers.include? User.find(user.id)
  end

  def score user
    hoppers_hops = ActiveRecord::Base.connection.select_all("SELECT pts FROM hoppers_hops WHERE user_id = #{user.id} AND hop_id = #{id} LIMIT 1")
    ActiveRecord::Base.connection.close
    if hoppers_hops.length == 0
      0
    else
      hoppers_hops[0]['pts']
    end
  end

  def increase_score user, pts
    current_pts = self.score user
    ActiveRecord::Base.connection().execute("UPDATE hoppers_hops SET pts = #{current_pts + pts} WHERE user_id = #{user.id} AND hop_id = #{id}")
    ActiveRecord::Base.connection.close
  end

  def rank user
    user_position = ActiveRecord::Base.connection.select_all("
      SELECT rank FROM
      (
        SELECT hoppers_hops.user_id, @rownum := @rownum + 1 AS rank
        FROM hoppers_hops, (SELECT @rownum := 0) r
        WHERE hop_id = #{id}
        ORDER BY hoppers_hops.pts DESC
      ) selection
      WHERE user_id = #{user.id};
    ")
    ActiveRecord::Base.connection.close
    if user_position.length > 0
      user_position = user_position[0]['rank']
    else
      user_position = 0
    end
  end

  def winner place
    winner = ActiveRecord::Base.connection.select_all("SELECT hoppers_hops.* FROM hoppers_hops WHERE hop_id = #{id} ORDER BY pts, RAND() DESC LIMIT 1 OFFSET #{ place - 1 };")
    ActiveRecord::Base.connection.close
    if winner.blank?
      nil
    else
      winner[0]
    end
  end

  def hop_end
    self.time_end < DateTime.now
  end

  def self.find_old
    find(:all, :conditions => ["((time_end < ? AND daily = 0) OR (time_start < ? AND daily = 1)) AND close = 0", DateTime.now, DateTime.now.beginning_of_day ])
  end

  def self.close_old_hops
    @old_hops = Hop.find_old
    @old_hops.each do |hop|
      #mark hop as closed
      hop.update_attribute :close, true
      hop.prizes.each do |prize|
        winner = hop.winner prize.place
        if winner
          #set prize user
          prize.update_attribute :user_id, winner['id']
          prize.update_attribute :pts, winner['pts']
          #send message to winner
          message = Message.new(text: "You have won #{prize.place} prize in a hop #{ hop.name }", receiver_id: winner['id'])
          message.save
        end
      end
    end
  end

  def free?
    price.blank? || price == 0
  end

  def self.import_from_excel(import_file)
    Spreadsheet.client_encoding = 'UTF-8'

    temp = Tempfile.new([import_file.original_filename, '.xls' ])
    temp.binmode
    temp.write(import_file.read)
    temp.close



      oo = Roo::Excel.new("#{temp.path}")

      oo.default_sheet = oo.sheets.first
      new_hop = {}
      hop_items = []
      hop_item = {}

      hop_row=0
      hop_items_row=0
      hop_winner_row=0
      hop_ad_row = 0
      row_size = oo.last_row
      col_size = oo.last_column
      1.upto(row_size ) do |i|
        if oo.cell(i,1) == 'Hop' || oo.cell(i,1) == 'hop'
          hop_row = i
        end
        if oo.cell(i,1) == 'Hop item' || oo.cell(i,1) == 'hop item'
          hop_items_row = i
        end
        if oo.cell(i,1) == 'Hop ad' || oo.cell(i,1) == 'hop ad'
          hop_ad_row = i
        end
        if oo.cell(i,1) == 'Winner' || oo.cell(i,1) == 'winner'
          hop_winner_row = i
        end
      end



      hop_row.upto(hop_winner_row ) do |i|
        1.upto(col_size) do |j|
          new_hop[:name] =  oo.cell(i + 1,j) if oo.cell(i,j) == 'Name' ||  oo.cell(i,j) == 'name'
          new_hop[:daily] = 0
          new_hop[:close] = 0
          new_hop[:code] = oo.cell(i + 1,j).to_s  if oo.cell(i,j) == 'Code' ||  oo.cell(i,j) == 'code'
          new_hop[:time_start] = oo.cell(i + 1,j)  if oo.cell(i,j) == 'Time start' ||  oo.cell(i,j) == 'time start'
          new_hop[:time_end] = oo.cell(i + 1,j)   if oo.cell(i,j) == 'Time end' ||  oo.cell(i,j) == 'time end'
          new_hop[:price] = oo.cell(i + 1,j).to_s   if oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price'
          new_hop[:producer_id]=  oo.cell(i + 1,j).to_i  if oo.cell(i,j) == 'Showprod id' ||  oo.cell(i,j) == 'showprod id'
          new_hop[:jackpot]=  oo.cell(i + 1,j).to_s if oo.cell(i,j) == 'Jackpot' ||  oo.cell(i,j) == 'jackpot'
          new_hop[:event]=  oo.cell(i + 1,j).to_s  if oo.cell(i,j) == 'Special event' ||  oo.cell(i,j) == 'Special event'

        end
      end



      hop_winners = []
      hop_winner = {}
      hop_winner_row.upto(hop_items_row -1) do |i|
        1.upto(col_size) do |j|
          if oo.cell(i,j) == 'Place' ||  oo.cell(i,j) == 'place'
            (i+1).upto(hop_items_row-1 ) do |c|
              hop_winner[c] = {}
              1.upto(col_size) do |j|
                hop_winner[c][:place] = oo.cell(c, j).to_s  if (oo.cell(i,j) == "Place" ||  oo.cell(i,j) == "place") &&  !oo.cell(c, j).nil?
                hop_winner[c][:cost] = oo.cell(c,j).to_s  if (oo.cell(i,j) == 'Prize' ||  oo.cell(i,j) == 'prize') &&  !oo.cell(c, j).nil?
                hop_winner[c][:prize_type] = oo.cell(c,j).to_s  if (oo.cell(i,j) == 'Prize type' ||  oo.cell(i,j) == 'prize type') &&  !oo.cell(c, j).nil?

              end
              hop_winners <<  hop_winner[c] if !oo.cell(c, j).nil?

            end
          end
        end
      end


      hop_items_row.upto(hop_ad_row -1) do |i|
        1.upto(col_size) do |j|
          if oo.cell(i,j) == 'Hop item description' ||  oo.cell(i,j) == 'hop item description'
            (i+1).upto(hop_ad_row-1 ) do |c|
              hop_item[c] = {}
              1.upto(col_size) do |j|
                hop_item[c][:text] = oo.cell(c, j)  if (oo.cell(i,j) == "Hop item description" ||  oo.cell(i,j) == "hop item description") &&  !oo.cell(c, j).nil?
                hop_item[c][:sponsor_id] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'Sponsor id' ||  oo.cell(i,j) == 'sponsor id') &&  !oo.cell(c, j).nil?
                hop_item[c][:pts] = oo.cell(c,j).to_i if (oo.cell(i,j) == 'PTS' ||  oo.cell(i,j) == 'pts')  &&  !oo.cell(c, j).nil?
                hop_item[c][:bonus] = oo.cell(c,j).to_i   if (oo.cell(i,j) == 'Bonus' ||  oo.cell(i,j) == 'bonus')  &&  !oo.cell(c, j).nil?
                hop_item[c][:price] = oo.cell( c,j).to_i  if (oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price')  &&  !oo.cell(c, j).nil?
                hop_item[c][:amt_paid]=  oo.cell(c,j).to_i if (oo.cell(i,j) == 'Amt paid' ||  oo.cell(i,j) == 'amt paid') &&  !oo.cell(c, j).nil?
              end
              hop_items <<  hop_item[c] if !oo.cell(c, j).nil?
            end
          end
        end
      end


      hop_ad = {}
      hop_ads = []

      hop_ad_row.upto(row_size) do |i|
        1.upto(col_size) do |j|
          if oo.cell(i,j) == 'Position' ||  oo.cell(i,j) == 'position'
            (i+1).upto(row_size ) do |c|
              hop_ad[c] = {}
              1.upto(col_size) do |j|

                hop_ad[c][:ad_type] = oo.cell(c, j)  if (oo.cell(i,j) == 'Position' ||  oo.cell(i,j) == 'position') &&  !oo.cell(c, j).nil?
                hop_ad[c][:text] = oo.cell(c, j)  if (oo.cell(i,j) == "Hop item description" ||  oo.cell(i,j) == "hop item description") &&  !oo.cell(c, j).nil?
                hop_ad[c][:advertizer_id] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'Advertiser id' ||  oo.cell(i,j) == 'advertiser id') &&  !oo.cell(c, j).nil?
                hop_ad[c][:price] = oo.cell( c,j).to_i  if (oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price')  &&  !oo.cell(c, j).nil?
                hop_ad[c][:amt_paid]=  oo.cell(c,j).to_i if (oo.cell(i,j) == 'Amt paid' ||  oo.cell(i,j) == 'amt paid') &&  !oo.cell(c, j).nil?
                hop_ad[c][:link]=  oo.cell(c,j) if (oo.cell(i,j) == 'Link to ad' ||  oo.cell(i,j) == 'link to ad') &&  !oo.cell(c, j).nil?
              end
              hop_ads <<  hop_ad[c] if !oo.cell(c, j).nil?

            end
          end
        end
      end


    return new_hop, hop_items, hop_ads, hop_winners
  end

  def self.save_items_and_add_from_excel(hop, items, ads, winners)
      @exp = []
      for i in ads
        ad = hop.ads.new(i)
        @exp << ad.errors.messages  unless ad.save
      end
      for i in items
        item = hop.hop_tasks.new(i)
        @exp << item.errors.messages   unless item.save

      end
      for i in winners
        winner = hop.prizes.new(i)
        @exp << winner.errors.messages   unless winner.save
      end
    @exp
  end

  def self.notificate_about_end
    @hops = Hop.where(['time_end < ? AND notificated_about_end = 0', Time.now + 1.day])
    puts @hops.count
    puts '-------------------------------'
    @hops.each do |hop|
      hop.hoppers.each do |user|
        if !hop.completed? user
          Notification.create(user_id: user.id, friend_id: nil, event_type: 'Hop about to end', hop_id: hop.id)
        end
      end
      hop.update_attribute :notificated_about_end, true
    end
  end

  def completed? user
    completed = true
    self.hop_tasks.each do |task|
      user_hop_tasks = UserHopTask.where(hop_task_id: task.id, user_id: user.id)
      if user_hop_tasks.count == 0
        completed = false
      end
    end
    completed
  end

  private

  def only_one_daily_hop_per_day
    if daily && Hop.get_daily_by_date(self.time_start)
      errors.add(:start_date, "Can be only one daily hop per day.")
    end
  end

end