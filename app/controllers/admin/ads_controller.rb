class Admin::AdsController < Admin::AdminController
  # GET /ads
  # GET /ads.json
  def index
    @hop_ads = Ad.where(:hop_id => nil).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @hop_ads }
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @hop_ad = Ad.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @hop_ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.json
  def new
    @hop_ad = Ad.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @hop_ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @hop_ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.json
  def create

    if params["hop_id"]
      @hop=Hop.find(params["hop_id"])
      params[:ad]["hop_id"]=params["hop_id"]
    end

    @hop_ad=Ad.new(params[:ad])


    if @hop_ad.save

       if params["hop_id"]
         redirect_to admin_hop_path(@hop), notice:'Hop ad was successfully created.'
       else
         redirect_to admin_ad_path(@hop_ad.id), notice:'Hop ad was successfully created.'
       end

    else

      if params["hop_id"]
        flash[:hop_ad_error] = @hop_ad.errors.full_messages
        redirect_to  admin_hop_path(@hop)
      else
        render  'new'
      end
    end

  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @hop_ad = Ad.find(params[:id])


    respond_to do |format|
      if @hop_ad.update_attributes(params[:ad])
        if @hop_ad.hop
          format.html { redirect_to admin_hop_path(@hop_ad.hop), notice: 'Hop ad was successfully updated.' }
        else
          format.html { redirect_to admin_ad_path(@hop_ad.id), notice:'Hop ad was successfully created.' }
        end

          format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hop_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @hop_ad = Ad.find(params[:id])
    @hop_ad.destroy

    respond_to do |format|
      if @hop_ad.hop
        format.html {redirect_to admin_hop_path(@hop_ad.hop) }
      else
        format.html { redirect_to admin_ads_path, notice:'Hop ad was successfully created.' }
      end
      format.json { head :no_content }
    end
  end
end
