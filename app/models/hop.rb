class Hop < ActiveRecord::Base
  has_and_belongs_to_many :hoppers, :join_table =>"hoppers_hops" , :class_name=>"User"

  has_many :hop_tasks, :dependent => :destroy
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

  def self.import_from_excel(import_file)
    Spreadsheet.client_encoding = 'UTF-8'

    File.open(Rails.root.join('public','excel', import_file.original_filename), 'wb+') do |file|
      file.write(import_file.read)
    end

    if import_file.original_filename.split(".").last == "xls"
      oo = Roo::Excel.new("#{Rails.root}/public/excel/#{import_file.original_filename}")
      oo.default_sheet = oo.sheets.first
      @new_hop = {}
      @hop_items = []
      @hop_item = {}
      @hop_ad = {}
      @hop_ads = []
      hop_row=0
      hop_items_row=0
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
      end

      hop_row.upto(hop_items_row ) do |i|
        1.upto(col_size) do |j|
          @new_hop[:name] =  oo.cell(i + 1,j) if oo.cell(i,j) == 'Name' ||  oo.cell(i,j) == 'name'
          @new_hop[:code] = oo.cell(i + 1,j)  if oo.cell(i,j) == 'Code' ||  oo.cell(i,j) == 'code'
          @new_hop[:time_start] = oo.cell(i + 1,j)  if oo.cell(i,j) == 'Time start' ||  oo.cell(i,j) == 'time start'
          @new_hop[:time_end] = oo.cell(i + 1,j)   if oo.cell(i,j) == 'Time end' ||  oo.cell(i,j) == 'time end'
          @new_hop[:price] = oo.cell(i + 1,j).to_i   if oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price'
          @new_hop[:producer_id]=  oo.cell(i + 1,j).to_i  if oo.cell(i,j) == 'Showprod_id' ||  oo.cell(i,j) == 'showprod_id'
          @new_hop[:jackpot]=  oo.cell(i + 1,j).to_i  if oo.cell(i,j) == 'Jackpot' ||  oo.cell(i,j) == 'jackpot'
          @new_hop[:event]=  oo.cell(i + 1,j)  if oo.cell(i,j) == 'Special event' ||  oo.cell(i,j) == 'Special event'
        end
      end

      hop_items_row.upto(hop_ad_row -1) do |i|
        1.upto(col_size) do |j|
          if oo.cell(i,j) == 'Hop item description' ||  oo.cell(i,j) == 'hop item description'
            (i+1).upto(hop_ad_row-1 ) do |c|
              @hop_item[c] = {}
              1.upto(col_size) do |j|
                @hop_item[c][:text] = oo.cell(c, j)  if (oo.cell(i,j) == "Hop item description" ||  oo.cell(i,j) == "hop item description") &&  !oo.cell(c, j).nil?
                @hop_item[c][:sponsor_id] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'Sponsor id' ||  oo.cell(i,j) == 'sponsor id') &&  !oo.cell(c, j).nil?
                @hop_item[c][:pts] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'PTS' ||  oo.cell(i,j) == 'pts')  &&  !oo.cell(c, j).nil?
                @hop_item[c][:bonus] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'Bonus' ||  oo.cell(i,j) == 'bonus')  &&  !oo.cell(c, j).nil?
                @hop_item[c][:price] = oo.cell( c,j).to_i  if (oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price')  &&  !oo.cell(c, j).nil?
                @hop_item[c][:amt]=  oo.cell(c,j).to_i if (oo.cell(i,j) == 'Amt paid' ||  oo.cell(i,j) == 'amt paid') &&  !oo.cell(c, j).nil?
              end
              @hop_items <<  @hop_item[c] if !oo.cell(c, j).nil?
            end
          end
        end
      end


      hop_ad_row.upto(row_size) do |i|
        1.upto(col_size) do |j|
          if oo.cell(i,j) == 'Position' ||  oo.cell(i,j) == 'position'
            (i+1).upto(row_size ) do |c|
              @hop_ad[c] = {}
              1.upto(col_size) do |j|
                @hop_ad[c][:ad_type] = oo.cell(c, j)  if (oo.cell(i,j) == 'Position' ||  oo.cell(i,j) == 'position') &&  !oo.cell(c, j).nil?
                @hop_ad[c][:text] = oo.cell(c, j)  if (oo.cell(i,j) == "Hop item description" ||  oo.cell(i,j) == "hop item description") &&  !oo.cell(c, j).nil?
                @hop_ad[c][:sponsor_id] = oo.cell(c,j).to_i  if (oo.cell(i,j) == 'Advertiser id' ||  oo.cell(i,j) == 'advertiser id') &&  !oo.cell(c, j).nil?
                @hop_ad[c][:price] = oo.cell( c,j)  if (oo.cell(i,j) == 'Price' ||  oo.cell(i,j) == 'price')  &&  !oo.cell(c, j).nil?
                @hop_ad[c][:amt]=  oo.cell(c,j).to_i if (oo.cell(i,j) == 'Amt paid' ||  oo.cell(i,j) == 'amt paid') &&  !oo.cell(c, j).nil?
                @hop_ad[c][:link_to_ad]=  oo.cell(c,j) if (oo.cell(i,j) == 'Link to ad' ||  oo.cell(i,j) == 'link to ad') &&  !oo.cell(c, j).nil?
              end
              @hop_ads <<  @hop_ad[c] if !oo.cell(c, j).nil?
            end
          end
        end
      end
    end
    return @new_hop, @hop_items, @hop_ads
  end


end