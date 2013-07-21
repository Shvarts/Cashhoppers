class Admin::HopTasksController < Admin::AdminController

  def index
    @hop = Hop.find(params[:hop_id])
    @tasks = @hop.hop_tasks
    render partial: 'tasks'
  end

  def new
    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.build
    render partial: 'form'
  end


  def edit
    @hop_task = HopTask.find(params[:id])
    @hop = @hop_task.hop
  end


  def create
    @hop_task = HopTask.new(params[:hop_task])
    @hop_task.sponsor = current_user
    if @hop_task.save
      render text: 'ok'
    else
      render partial: 'form'
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
