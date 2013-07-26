class Admin::AdsController < Admin::AdminController

  def regular_hop_ads
    @hop = Hop.find(params[:hop_id])
    @ads = @hop.ads
    render partial: 'regular_hop_ads'
  end

  def new
    @hop = Hop.find(params[:hop_id])
    @ad = @hop.ads.build
    render partial: 'form'
  end

  def create
    @ad = Ad.new(params[:ad])
    @ad.advertizer = current_user
    if @ad.save
      render text: 'ok'
    else
      render partial: 'form'
    end
  end

end
