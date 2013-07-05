class Api::AdsController < Api::ApplicationController

  def index
    if params[:ad_type].present?
      @ads = Ad.find_all_by_ad_type(params[:ad_type])
    elsif params[:hop_id].present?
      @ads = Ad.find_all_by_hop_id(params[:hop_id])
    end

    invalid_login_attempt('ads not found') if @ads.blank?
  end

end
