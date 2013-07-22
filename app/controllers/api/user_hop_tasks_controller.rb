class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json

  #before_filter :load_hop, only: [:create]

  def events_list
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.paginate(page: params[:page], per_page: params[:per_page], :order => 'created_at DESC')
  end

  def create
    hop_task = HopTask.where(id: params[:task][:hop_task_id]).first
    unless hop_task
      bad_request(['Hop task not found.'], 406) unless @hop
    else
      params[:task][:user_id] = @current_user.id
      @task = UserHopTask.new(params[:task])
      if @task.save
        render :json => {success: true,
                         info: "Task create!",
                         status: 200
        }
      else
        bad_request(@task.errors.to_json, 406)
      end
    end
  end

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first
    bad_request(['Hop not found.'], 406) unless @hop
  end

end