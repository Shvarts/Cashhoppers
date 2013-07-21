class Admin::HopsController < Admin::AdminController

  before_filter :init_hop, only: [:show, :edit_regular]

  def regular
    @tab = 'hops'
    conditions = {:daily => false}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def daily
    @tab = 'daily_hops'
    conditions = {:daily => true}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def show
    @hop_task_errors=params[:hop_task_errors].to_json
    @hop_task = HopTask.new

    @hop_ad=Ad.new
  end

  def new_regular
    @tab = 'hops'
    @hop = Hop.new
    @hop.daily = false
  end

  def new_daily
    @tab = 'hops'
    @hop = Hop.new
    @hop.daily = true
  end

  def create
    params[:hop][:producer_id] = current_user.id
    @hop = Hop.new(params[:hop])
    if @hop.save
      redirect_to [:admin, @hop ] , notice: 'Hop was successfully created.'
    else
      if @hop.daily
        render action: 'new_daily'
      else
        render action: 'new_regular'
      end
    end

  end

  def edit_regular
    @hop = Hop.find(params[:id])
  end

  def edit_daily
    @hop = Hop.find(params[:id])
  end

  def update
    @hop = Hop.find(params[:id])
    if @hop.update_attributes(params[:hop])
      redirect_to [:admin, @hop ], notice: 'Hop was successfully updated.'
    else
      if hop.daily
        render action: 'edit_daily'
      else
        render action: 'edit_regular'
      end
    end
  end

  def destroy
    @hop = Hop.find(params[:id])
    daily_hop = @hop.daily
    @hop.destroy
    if daily_hop
      redirect_to admin_daily_hops_path
    else
      redirect_to admin_regular_hops_path
    end
  end
  #
  #def close
  #  @hop = Hop.find(params[:id])
  #
  #  respond_to do |format|
  #    if @hop.update_attributes(:close=>1)
  #      format.html { redirect_to admin_hops_path({:daily_hop => @hop.daily_hop}) , notice: 'Hop was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @hop.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def sub_layout
    'admin/hops_tabs'
  end

  private

  def init_hop
    @hop = Hop.find(params[:id])
    if @hop.daily
      @tab = 'daily_hops'
    else
      @tab = 'hops'
    end
  end

end
