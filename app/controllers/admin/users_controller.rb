class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  def index
    @users_grid = initialize_grid(User,
                                 :include => [:roles, :user_settings],
                                  per_page: 20
                                     )


    puts "----------------------------------------------#{params}----------------------------"
    puts "----------------------------------------------#{params}----------------------------"
    puts "----------------------------------------------#{params}----------------------------"
    if params[:subscribe]
      user = User.find_by_id(params[:user_id].to_i)
      subscribe = (params[:subscribe]== 'true')?  true : false
      if user.user_settings.nil?
        set = user.build_user_settings(:unsubscribe =>  subscribe)
        set.save
      else
       test = user.user_settings.update_attributes(:unsubscribe =>  subscribe)
        puts "----------------------------------------------#{ subscribe}----------------------------"
        puts "----------------------------------------------#{ subscribe}----------------------------"
        puts "----------------------------------------------#{ subscribe}----------------------------"
      end
      render :partial => 'user_list'
    end

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

  def unsubscribe_user
    render :partial => 'user_list'
  end
end
