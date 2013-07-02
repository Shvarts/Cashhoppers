class Admin::HopsController < Admin::AdminController
  # GET /hops
  # GET /hops.json
  before_filter :authenticate_user!

  def index
   if params[:daily_hop]
     @daily_hop=1
     @hops= Hop.where(:daily_hop => 1, :close=>nil).all
   else
     @hops = Hop.where(:daily_hop => nil, :close=>nil).all
   end



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hops }
    end
  end

  # GET /hops/1
  # GET /hops/1.json
  def show

    @hop = Hop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hop }
    end
  end

  # GET /hops/new
  # GET /hops/new.json
  def new

    @hop = Hop.new
    @hop.daily_hop=params["daily_hop"]


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hop }
    end
  end

  # GET /hops/1/edit
  def edit
    @hop = Hop.find(params[:id])
  end

  # POST /hops
  # POST /hops.json
  def create
    params[:hop][:producer_id]=current_user.id
   #hop_time_end_4i




    @hop = Hop.new(params[:hop])

    respond_to do |format|
      if @hop.save
        format.html { redirect_to [:admin, @hop ] , notice: 'Hop was successfully created.' }
        format.json { render json: [:admin, @hop ], status: :created, location: @hop }
      else
        format.html { render action: "new" }
        format.json { render json: [:admin, @hop ].errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hops/1
  # PUT /hops/1.json
  def update
    @hop = Hop.find(params[:id])

    respond_to do |format|
      if @hop.update_attributes(params[:hop])
        format.html { redirect_to [:admin, @hop ], notice: 'Hop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hops/1
  # DELETE /hops/1.json
  def destroy
    @hop = Hop.find(params[:id])

    @hop.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @hop ] }
      format.json { head :no_content }
    end
  end

  def close
    @hop = Hop.find(params[:id])

    respond_to do |format|
      if @hop.update_attributes(:close=>1)
        format.html { redirect_to admin_hops_path , notice: 'Hop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hop.errors, status: :unprocessable_entity }
      end
    end
  end
end
