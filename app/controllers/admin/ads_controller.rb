class Admin::AdsController < Admin::AdminController

  def index
    @hop = Hop.where(id: params[:hop_id]).first
    @ads = Ad.ads_for_hop @hop
    if @hop
      render partial: 'list'
    end
  end

  def new
    @hop = Hop.find(params[:hop_id])
    @ad = @hop.ads.build
    render partial: 'form'
  end

  def create
    @hop = Hop.find(params[:ad][:hop_id])
    @ad = Ad.new(params[:ad])
    @ad.advertizer = current_user
    if @ad.save
      render text: 'ok'
    else
      render partial: 'form'
    end
  end

  def edit
    @ad = Ad.find(params[:id])
    @hop = @ad.hop
    render partial: 'form'
  end

  def update
    @ad = Ad.find(params[:id])
    @hop = @ad.hop
    if @ad.update_attributes(params[:ad])
      render text: 'ok'
    else
      render partial: 'form'
    end
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    render text: 'ok'
  end

end
