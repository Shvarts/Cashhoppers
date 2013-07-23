class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json

  def hoppers_activity
    #params[:page] ||= 1
    #params[:per_page] ||= 10
    #@tasks = UserHopTask.paginate(page: params[:page], per_page: params[:per_page], :order => 'created_at DESC')
    #@user_hop_tasks = UserHopTask.select_by_sql("SELECT user_hop_tasks.* FROM users
    #    RIGHT JOIN hoppers_hops ON users.id = hoppers_hops.user_id
    #    RIGHT JOIN hops ON hops.id = hoppers_hops.hop_id
    #    RIGHT JOIN hop_tasks ON hop_tasks.hop_id = hops.id
    #    RIGHT JOIN user_hop_tasks ON user_hop_tasks.hop_task_id = hop_tasks.id
		 # WHERE users.id = 1
		 # ORDER BY user_hop_tasks.created_at;")
    #render :text => @user_hop_tasks.to_json
  end

  def create
    hop_task = HopTask.where(id: params[:hop_task_id]).first
    unless hop_task
      bad_request(['Hop task not found.'], 406) unless @hop
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

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first
    bad_request(['Hop not found.'], 406) unless @hop
  end

end