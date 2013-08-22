class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  def index
    @users_grid = initialize_grid(User,  per_page: 20)
  end

  def change_user_role
    puts "----------------------------------------------#{params}----------------------------"
    user = User.find_by_id(params[:user_id])
    role = Role.find_by_id(params[:new_role_id])
    if user && role
      user.roles = [role]
      render :text => "Succesfully changed "+user.email + " role to " + role.name
    else
      render :text => "error"
    end
  end
  def tasks_photo
    @hop = params[:hop_id]
    @hop_task_id = Hop.find_by_id( @hop).hop_tasks.map{|item| item.id}
    @photos  = UserHopTask.where(:user_id => params[:user_id], :hop_task_id =>@hop_task_id )

  end
end
