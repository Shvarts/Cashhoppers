class Admin::HopAdsController < Admin::AdminController
  # GET /hop_ads
  # GET /hop_ads.json
  def index
    @hop_ads = HopAd.where(:hop_id => nil).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @hop_ads }
    end
  end

  # GET /hop_ads/1
  # GET /hop_ads/1.json
  def show
    @hop_ad = HopAd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hop_ad }
    end
  end

  # GET /hop_ads/new
  # GET /hop_ads/new.json
  def new
    @hop_ad = HopAd.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @hop_ad }
    end
  end

  # GET /hop_ads/1/edit
  def edit
    @hop_ad = HopAd.find(params[:id])
  end

  # POST /hop_ads
  # POST /hop_ads.json
  def create

    if params["hop_id"]
      @hop=Hop.find(params["hop_id"])
      params[:hop_ad]["hop_id"]=params["hop_id"]
    end

    @hop_ad = HopAd.new(params[:hop_ad])
#                           :contact=>params["contact"],
 #                           :email=>params["email"],
 #                           :phone=>params["phone"],
 #                           :price=>params["price"],
 #                           :ad_type=>params["ad_type"],
 #                           :hop_ad_picture =>params["hop_ad_picture"],
 #                           :hop_id => params["hop_id"] )
 #
    respond_to do |format|
     if @hop_ad.save

       if params["hop_id"]
         format.html { redirect_to :back, notice:'Hop ad was successfully created.' }
       else
         format.html { redirect_to admin_hop_ad_path(@hop_ad.id), notice:'Hop ad was successfully created.' }
       end
      format.json { render json: @hop_ad, status: :created, location: @hop_ad }
      else
        format.html { render action: "new" }
        format.json { render json: @hop_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hop_ads/1
  # PUT /hop_ads/1.json
  def update
    @hop_ad = HopAd.find(params[:id])

    respond_to do |format|
      if @hop_ad.update_attributes(params[:hop_ad])
        if @hop_ad.hop
          format.html { redirect_to admin_hop_path(@hop_ad.hop), notice: 'Hop ad was successfully updated.' }
        else
          format.html { redirect_to admin_hop_ad_path(@hop_ad.id), notice:'Hop ad was successfully created.' }
        end

          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hop_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hop_ads/1
  # DELETE /hop_ads/1.json
  def destroy
    @hop_ad = HopAd.find(params[:id])
    @hop_ad.destroy

    respond_to do |format|
      if @hop_ad.hop
        format.html {redirect_to admin_hop_path(@hop_ad.hop) }
      else
        format.html { redirect_to admin_hop_ads_path, notice:'Hop ad was successfully created.' }
      end
      format.json { head :no_content }
    end
  end
end
