class Admin::HopsController < Admin::AdminController
  # GET /hops
  # GET /hops.json
  before_filter :authenticate_user!
  before_filter :parse_datetime_select, :only => [:create, :update]

  def index
  #  render :text=>params[:daily_hop].to_s.to_bool
   if params[:daily_hop].to_s.to_bool
     @daily_hop=1
     @hops= Hop.daily_all
   else
     @hops = Hop.regular
   end

 end

  # GET /hops/1
  # GET /hops/1.json
  def show

    @hop = Hop.find(params[:id])
    @hop_task_errors=params[:hop_task_errors].to_json
    @hop_task = HopTask.new

    @hop_ad=Ad.new
    puts "_________________________________________________________________"
    puts params
    puts "_________________________________________________________________"
  end


  def new
    @hop = Hop.new
    @hop.daily_hop = true if params[:daily_hop]

  end


  def edit
    @hop = Hop.find(params[:id])
    @hop.time_end=0
    @hop.time_start=0
  end


  def create
    params[:hop][:producer_id]=current_user.id
    @hop = Hop.new(params[:hop])


      if @hop.save
        redirect_to [:admin, @hop ] , notice: 'Hop was successfully created.'
      else
        render action: "new"
      end

  end

  def update

    @hop = Hop.find(params[:id])

    respond_to do |format|
      if @hop.update_attributes(params[:hop])
        redirect_to [:admin, @hop ], notice: 'Hop was successfully updated.'

      else
        render action: "edit"

      end
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

  private
  def parse_datetime_select

    date=[params[:date_start].to_a,params[:date_end].to_a]
    if date.flatten.include?('')
      params[:hop][:time_start]=params[:hop][:time_end]=nil
    else
      {:date_start => :time_start, :date_end => :time_end}.each_pair do |k, v|
      p = params[k]
      params[:hop][v] = DateTime.new(Date.today.year,
                                     p["#{v}(2i)"].to_i,
                                     p["#{v}(3i)"].to_i,
                                     p["#{v}(4i)"].to_i,
                                     p["#{v}(5i)"].to_i)
      end
    end
  end
end
