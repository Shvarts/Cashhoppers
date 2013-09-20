class Api::AdsController < Api::ApplicationController

  def index



    @hop = Hop.where(:id => params[:hop_id]).first

    types = []
    Ad.types(@hop).each do |type|

      types << type[1]
    end



    if params[:ad_type].present? && @hop && types.include?(params[:ad_type])
      @ad = Ad.where(hop_id: params[:hop_id], ad_type: params[:ad_type]).order("RAND()").first
      if params[:ad_type] == 'SP' && @ad == nil
        @ad = Ad.where(hop_id: params[:hop_id], ad_type: 'ROFL').order("RAND()").first
      end
      bad_request ['Ads not found.'], 406 unless @ad
    elsif params[:ad_type].present? && types.include?(params[:ad_type])

      @ad = Ad.where(ad_type: params[:ad_type]).order("RAND()").first
      bad_request ['Ads not found.'], 406 unless @ad
    else
      bad_request ['Invalid type.'], 406
    end

    respond_to do |f|
      f.json{}
    end

  end

end
