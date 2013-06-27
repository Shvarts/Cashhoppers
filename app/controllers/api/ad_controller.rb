class Api::AdController < ApplicationController

  def send_ad
    if params["ad_type"] and params["hop_id"]

       if @ad= Ad.where(:type_add =>  params["ad_type"]).where(:hop_id=>params["hop_id"])

          render :json => { :picture_url => @ad.inspect, :success => true},  :success => true, :status => :ok
      else
          render :json => { :picture_url => "no find", :success => false},  :success => false, :status => :ok
      end
    end
  end

end
