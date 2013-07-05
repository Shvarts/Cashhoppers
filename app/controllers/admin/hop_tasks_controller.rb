class Admin::HopTasksController < Admin::AdminController


  before_filter :authenticate_user!

  def index
    @hop = Hop.find(params[:hop_id])
    @hop_tasks = @hop.hop_tasks


  end


  def show

    @hop_task = HopTask.find(params[:id])


  end


  def new

    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.build

  end


  def edit
    @hop_task=HopTask.find(params[:id])
    @hop=@hop_task.hop


  end


  def create
    params[:hop_task][:sponsor_id]=current_user.id


    @hop=Hop.find(params["hop_id"])
    @hop_task = @hop.hop_tasks.new(params[:hop_task])

      if @hop_task.save
         redirect_to :back, :notice => 'Hop task was successfully created.'
      else
          redirect_to admin_hop_path(@hop)

      end

  end


  def update


    @hop_task = HopTask.find(params[:id])

    if @hop_task.update_attributes(params[:hop_task])
      redirect_to(admin_hop_path(@hop_task.hop), :notice => 'Hop task was successfully updated.')
    else
      render :action => "edit"
    end

  end


  def destroy

    @hop_task = HopTask.find(params[:id])
    @hop=@hop_task.hop
    @hop_task.destroy


    redirect_to admin_hop_path(@hop)

  end
end
