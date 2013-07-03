include AdsHelper
class Api::AdController < ApplicationController

  before_filter :check_api_key

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

  private

  def check_api_key
    if Application.where(:api_key => params[:api_key]).blank?
      invalid_login_attempt 'Bad api key'
    end
  end

end
