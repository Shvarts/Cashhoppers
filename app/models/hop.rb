class Hop < ActiveRecord::Base
  has_many :hop_tasks, :dependent => :destroy
  has_many :ads,  :dependent => :destroy
  belongs_to :user

  attr_accessible :contact_email, :close, :event, :daily_hop, :contact_phone, :hop_code, :hop_items, :hop_price, :jackpot, :name, :producer_contact, :producer_id, :time_end, :time_start

  # get only active for default
  default_scope where(:close => false)
  scope :daily, where(:daily_hop => 1)
  scope :regular, where(:daily_hop => nil)



  def Hop.time_start(params)
#    time_start=DateTime.civil(h=0,m= params[:hop]['time_start(2i)'].to_i, d=params[:hop]['time_start(3i)'].to_i, h= params[:hop]['time_start(4i)'].to_i, min=params[:hop]['time_start(5i)'].to_i, s=0, of=0, sq=0)
    time_start="#{params[:date_start]['time_start(3i)'].to_i}.#{params[:date_start]['time_start(2i)'].to_i}-#{params[:date_start]['time_start(4i)'].to_i}:#{params[:date_start]['time_start(5i)'].to_i}"
    params.delete('date_start')
    params[:hop]['time_start']=time_start
    params
  end

  def Hop.time_end(params)
    time_start="#{params[:date_end]['time_end(3i)'].to_i}.#{params[:date_end]['time_end(2i)'].to_i}-#{params[:date_end]['time_end(4i)'].to_i}:#{params[:date_end]['time_end(5i)'].to_i}"
    params.delete('date_end')
    params[:hop]['time_end']=time_start
    params
  end

end

class String
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || "nil" || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
