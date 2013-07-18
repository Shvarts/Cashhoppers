class Admin::HopsController < Admin::AdminController
  # GET /hops
  # GET /hops.json
  before_filter :authenticate_user!
  before_filter :set_tabs

  def index
    if params[:daily_hop].to_s.to_bool
      @daily_hop = 1
      @hops = Hop.daily_all
      @tab = 'daily_hops'
    else
      @hops = Hop.regular
      @tab = 'hops'
    end
  end

  # GET /hops/1
  # GET /hops/1.json
  def show

    @hop = Hop.find(params[:id])
    @hop_task_errors=params[:hop_task_errors].to_json
    @hop_task = HopTask.new

    @hop_ad=Ad.new
  end


  def new
    @hop = Hop.new
    @hop.daily_hop = params[:daily_hop]? true: false

  end


  def edit
    @hop = Hop.find(params[:id])
    @hop.time_end=0
    @hop.time_start=0
  end


  def create
    params[:hop][:producer_id] = current_user.id
    @hop = Hop.new(params[:hop])

    if @hop.save
      redirect_to [:admin, @hop ] , notice: 'Hop was successfully created.'
    else
      render action: "new"
    end

  end

  def update
    @hop = Hop.find(params[:id])
    if @hop.update_attributes(params[:hop])
      redirect_to [:admin, @hop ], notice: 'Hop was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @hop = Hop.find(params[:id])
     @daily_hop=@hop.daily_hop
    @hop.destroy
    redirect_to admin_hops_path(:daily_hop => @daily_hop)
  end

  def close
    @hop = Hop.find(params[:id])

    respond_to do |format|
      if @hop.update_attributes(:close=>1)
        format.html { redirect_to admin_hops_path({:daily_hop => @hop.daily_hop}) , notice: 'Hop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hop.errors, status: :unprocessable_entity }
      end
    end
  end

  def sub_layout
    'admin/hops_tabs'
  end

  private

  def set_tabs
    if params[:daily_hop].to_s.to_bool
      @tab = 'daily_hops'
    else
      @tab = 'hops'
    end
  end

end
