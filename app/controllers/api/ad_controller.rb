include AdsHelper
class Api::AdController < ApplicationController

  def send_ad
    if params["ad_type"] and params["hop_id"]
      @ad = Ad.where(:type_add =>  params["ad_type"], :hop_id=>params["hop_id"]).first
      if @ad
          render :json => { :picture_url => @ad.ad_picture.url, :success => true},  :success => true, :status => :ok
      else
          render :json => { :picture_url => "no found", :success => false},  :success => false, :status => :ok
      end
    end
  end

end
