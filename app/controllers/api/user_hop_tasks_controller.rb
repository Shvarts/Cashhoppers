class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json

  def events_list
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.paginate(page: params[:page], per_page: params[:per_page], :order => 'created_at DESC')
  end

  def create
    @task = UserHopTask.new(params[:task])
    if @task.save
      render json: { :message => "Task create!" },  success: true, status: :ok
    else
      invalid_login_attempt(@task.errors.to_json) if @ads.blank?
    end
  end

end