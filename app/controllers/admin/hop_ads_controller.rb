class Admin::HopAdsController < Admin::AdminController
  # GET /hop_ads
  # GET /hop_ads.json
  def index
    @hop_ads = HopAd.all

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
      format.html # new.html.erb
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
    @hop=Hop.find(params["hop_id"])
    @hop_ad = HopAd.new(:sponsor_id=>current_user.id, :ad_name=>params["ad_name"],
                            :contact=>params["contact"],
                            :email=>params["email"],
                            :phone=>params["phone"],
                            :price=>params["price"],
                            # :hop_picture =>params["hop_picture"],
                            :hop_id => params["hop_id"] )

    respond_to do |format|
     if @hop_ad.save
 #       render :text=>params
       format.html { redirect_to :back, notice:'Hop ad was successfully created.' }
#      format.json { render json: @hop_ad, status: :created, location: @hop_ad }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @hop_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hop_ads/1
  # PUT /hop_ads/1.json
  def update
    @hop_ad = HopAd.find(params[:id])

    respond_to do |format|
      if @hop_ad.update_attributes(params[:hop_ad])
        format.html { redirect_to @hop_ad, notice: 'Hop ad was successfully updated.' }
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
      format.html { redirect_to hop_ads_url }
      format.json { head :no_content }
    end
  end
end
