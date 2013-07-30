class Admin::HopsController < Admin::AdminController

  before_filter :init_hop, only: [:show, :edit_regular, :edit_daily, :tasks]
  include ::PdfWritter

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

    output = PdfWritter::TestDocument.new.hops_to_pdf(Hop.where(:close => false).all)
    respond_to do |format|
      format.html
      format.pdf {
        send_data output, :filename => "Current_hops.pdf", :type => "application/pdf", :disposition => "inline"
      }
    end

  end

  def archived
    @tab = 'archived_hops'
    conditions = {close: true}
    @hops_grid = initialize_grid(Hop, include: [:producer], per_page: 20, :conditions => conditions,
                                 :order => 'created_at',
                                 :order_direction => 'desc')

    output = PdfWritter::TestDocument.new.hops_to_pdf(Hop.where(:close => true).all)
    respond_to do |format|
      format.html
      format.pdf {
        send_data output, :filename => "Current_hops.pdf", :type => "application/pdf", :disposition => "inline"
      }
    end

  end

  def show
    @tasks = @hop.hop_tasks
    @hoppers = @hop.hoppers
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


  def import_excel

    import_file = params[:excel]

    @new_hop, @hop_items,@hop_ads = Hop.import_from_excel(import_file)

    @hoppers = []
    @hop = Hop.new(@new_hop)
    if @hop.save
      for i in @hop_ads
        @hop.ads.create!(i)
      end
      @tasks = @hop.hop_tasks
      for i in @hop_items
        @hop.hop_tasks.create!(i)
      end
      render   action:  "show"
    else
      render  action: 'new_regular',  notice: "bad excel file"
    end

  end




  def print_hop_excel
    @hop = Hop.find_by_id(params[:id])
    @producer = User.find_by_id(@hop.producer_id)
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="hop.xls"'
    headers['Cache-Control'] = ''

    render :layout => false
  end

  def print_to_pdf
      output = PdfWritter::TestDocument.new.print_hop_pdf(params[:id])
      respond_to do |format|
        format.pdf {
          send_data output, :filename => "Hop.pdf", :type => "application/pdf", :disposition => "inline"
        }
      end

  end

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
