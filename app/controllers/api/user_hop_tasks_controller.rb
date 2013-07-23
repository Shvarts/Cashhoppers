class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json

  def create
    hop_task = HopTask.where(id: params[:hop_task_id]).first
    if !hop_task
      bad_request(['Hop task not found.'], 406)
    elsif UserHopTask.where(user_id: @current_user.id, hop_task_id: hop_task.id).first
      bad_request(['Hop task already comleted.'], 406)
    else
      hop_task.hop.assign @current_user
      hop_task_data = {}
      hop_task_data[:user_id] = @current_user.id
      hop_task_data[:hop_task_id] = params[:hop_task_id]
      hop_task_data[:photo] = params[:photo]
      hop_task_data[:comment] = params[:comment]
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

  def friends_hop_tasks
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.find_by_sql("SELECT * FROM user_hop_tasks WHERE user_hop_tasks.user_id IN (SELECT friendships.friend_id FROM friendships
                                      WHERE friendships.user_id = 1) LIMIT #{params[:per_page].to_i} OFFSET #{(params[:page].to_i - 1) * params[:per_page].to_i}")
    respond_to do |format|
      format.json{}
    end
  end

  def all_hoppers_hop_tasks
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.paginate(page: params[:page],
                                  per_page: params[:per_page],
                                  order: 'created_at DESC')
    respond_to do |format|
      format.json{}
    end
  end

  def get_hop_task_by_id
    @hop_task = HopTask.where(:id => params[:hop_task_id]).first
    unless @hop_task
      bad_request(['Hop task not found.'], 406)
    else
      respond_to do |format|
        format.json{}
      end
    end
  end

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first
    bad_request(['Hop not found.'], 406) unless @hop
  end

end