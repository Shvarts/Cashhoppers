class Admin::HopsController < Admin::AdminController

  before_filter :init_hop, only: [:show, :edit_regular, :edit_daily, :tasks]

  def regular
    @tab = 'hops'
    conditions = {daily: false, close: false}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def daily
    @tab = 'daily_hops'
    conditions = {daily: true, close: false}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def current
    @tab = 'current_hops'
    conditions = ["time_start < ? and (time_end > ? or daily = 1) and close = 0", Time.now.utc, Time.now.utc]
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def archived
    @tab = 'archived_hops'
    conditions = {close: true}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')
  end

  def show
    @tasks = @hop.hop_tasks
    @hoppers = @hop.hoppers
    @ads = Ad.ads_for_hop @hop
    @prizes = @hop.prizes
  end

  def new_regular
    @tab = 'hops'
    @hop = Hop.new
    @hop.daily = false
  end

  def new_daily
    @tab = 'daily_hops'
    @hop = Hop.new
    @hop.daily = true
  end

  def create
    params[:hop][:producer_id] = current_user.id
    params[:hop][:close] = false
    @hop = Hop.new(params[:hop])
    if @hop.daily
      @hop.time_end = @hop.time_start
    end
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

  end

  def edit_daily

  end

  def update
    @hop = Hop.find(params[:id])
    if @hop.daily
      @hop.time_end = @hop.time_start
    end
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

  def close
    @hop = Hop.find(params[:id])
    if @hop.update_attributes( close: 1)
        flash[:notice] = 'Hop was successfully closed.'
    else
        flash[:error] = 'Error update hop.'
    end
    redirect_to :back
  end

  def sub_layout
    'admin/hops_tabs'
  end

  def print_hop_to_pdf
     output = PdfWritter::TestDocument.new.print_hop_pdf(params[:id])
      respond_to do |format|
        format.pdf {
          send_data output, :filename => "Hop.pdf", :type => "application/pdf", :disposition => "inline"
        }
   end


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
