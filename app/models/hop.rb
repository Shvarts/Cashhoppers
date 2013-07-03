class Hop < ActiveRecord::Base
  has_many :hop_tasks, :dependent => :destroy
  has_many :hop_ads,  :dependent => :destroy
  belongs_to :user


  attr_accessible :contact_email, :close, :event, :daily_hop, :contact_phone, :hop_code, :hop_items, :hop_price, :jackpot, :name, :producer_contact, :producer_id, :time_end, :time_start


  def Hop.time_start(params)
    time_start="#{params[:hop]['time_start(3i)'].to_i}.#{params[:hop]['time_start(2i)'].to_i}-#{params[:hop]['time_start(4i)'].to_i}:#{params[:hop]['time_start(5i)'].to_i}"
    params[:hop].delete('time_start(1i)')
    params[:hop].delete('time_start(2i)')
    params[:hop].delete('time_start(3i)')
    params[:hop].delete('time_start(4i)')
    params[:hop].delete('time_start(5i)')
    params[:hop]['time_start']=time_start
    params
  end

  def Hop.time_end(params)
    time_start="#{params[:hop]['time_end(3i)'].to_i}.#{params[:hop]['time_end(2i)'].to_i}-#{params[:hop]['time_end(4i)'].to_i}:#{params[:hop]['time_end(5i)'].to_i}"
    params[:hop].delete('time_end(1i)')
    params[:hop].delete('time_end(2i)')
    params[:hop].delete('time_end(3i)')
    params[:hop].delete('time_end(4i)')
    params[:hop].delete('time_end(5i)')
    params[:hop]['time_end']=time_start
    params
  end

end
