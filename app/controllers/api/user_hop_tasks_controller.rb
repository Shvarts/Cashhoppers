class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json

  #before_filter :load_hop, only: [:create]

  def events_list
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.paginate(page: params[:page], per_page: params[:per_page], :order => 'created_at DESC')
  end

  def create
    hop_task = HopTask.where(id: params[:hop_task_id]).first
    unless hop_task
      bad_request(['Hop task not found.'], 406) unless @hop
    else
      hop_task_data = {}
      hop_task_data[:user_id] = @current_user.id
      hop_task_data[:hop_task_id] = params[:hop_task_id]
      hop_task_data[:photo] = params[:photo]
      @task = UserHopTask.new(hop_task_data)
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