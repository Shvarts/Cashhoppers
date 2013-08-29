class Admin::HopTasksController < Admin::AdminController
  authorize_resource

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
    render partial: 'form'
  end


  def create

    params[:hop_task][:creator_id] = current_user.id
    @hop_task = HopTask.new(params[:hop_task])

    if @hop_task.save


      render text: 'ok'
    else
      @hop_task.logo = nil
      render partial: 'form'

    end
  end

  def update
    @hop_task = HopTask.find(params[:id])
    if User.can_edit?(current_user, @hop_task.creator_id)
       puts
      if   @hop_task.update_attributes(params[:hop_task])
        render text: 'ok'
      else
        render partial: 'form'
      end
    else
      @hop_task.errors.messages[:access]=["Can not edit this task "] if @hop_task.errors.messages.blank?
      render partial: 'form'
    end
  end

  def destroy
    @hop_task = HopTask.find(params[:id])
    if User.can_edit?(current_user, @hop_task.creator_id)
      if User.can_edit?(current_user, @hop_task.creator_id)

        @hop_task.destroy
        render text: 'ok'
      else
        render text: 'ok'
      end
    else
      render text: 'ok'
    end
  end
end
