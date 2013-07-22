class Api::AdsController < Api::ApplicationController

  def index

  #ad_type: sp, rofl, ropu,
  #ad_type: log_in, hop_list, gallery, friends, message

    if params[:ad_type].present? && (params[:ad_type] == 'sp' || params[:ad_type] == 'rofl' || params[:ad_type] == 'ropu')
      @ads = Ad.where(hop_id: params[:hop_id], ad_type: params[:ad_type])
      bad_request ['Ads not found.'], 406 if @ads.blank?
    elsif params[:ad_type].present? && (params[:ad_type] == 'log_in' || params[:ad_type] == 'hop_list' || params[:ad_type] == 'gallery' || params[:ad_type] == 'message')
      @ads = Ad.where(ad_type: params[:ad_type])
      bad_request ['Ads not found.'], 406 if @ads.blank?
    else
      bad_request ['Invalid type.'], 406 if @ads.blank?
    end
  end

end
