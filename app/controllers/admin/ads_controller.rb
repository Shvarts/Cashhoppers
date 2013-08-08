class Admin::AdsController < Admin::AdminController
  load_and_authorize_resource
  def index
    @hop = Hop.where(id: params[:hop_id]).first
    if @hop
      @ads = Ad.ads_for_hop @hop
      render partial: 'list'
    else
      params[:type] ||= 'RPOU'
      conditions = {ad_type: params[:type]}
      @ads = Ad.paginate(page: params[:page], per_page:3, conditions: conditions  )
      if request.content_type == 'text'
        render layout: false
      end
    end
  end

  def new
    @hop = Hop.where(id: params[:hop_id]).first
    if @hop
      @ad = @hop.ads.build
    else
      @ad = Ad.new
      @ad.ad_type = params[:ad_type]
    end
    render partial: 'form'
  end

  def create
    @hop = Hop.where(id: params[:ad][:hop_id]).first
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

  def sub_layout
    'admin/ads/tabs'
  end

end
