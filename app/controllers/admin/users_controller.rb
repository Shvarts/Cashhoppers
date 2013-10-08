class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource
  def index
    puts '___________________________________delete_____________'
    puts "----------------------#{params}----"
    conditions = {deleted: !true}
    @users_grid = initialize_grid(User,
                                 :include => [:roles, :user_settings], :conditions => conditions,
                                  per_page: 20,

                                     )
    if params[:subscribe]
      user = User.find_by_id(params[:user_id].to_i)
      subscribe = (params[:subscribe]== 'true')?  true : false
      if user.user_settings.nil?
        set = user.build_user_settings(:unsubscribe =>  subscribe)
        set.save
      else
       test = user.user_settings.update_attributes(:unsubscribe =>  subscribe)
     end
      render :partial => 'user_list'
    #elsif params[:delete]
    #  #render :partial => 'user_list'
    #  respond_to do |format|
    #    format.js
    #   end
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

  def delete_user
    if params[:id]
      user = User.find_by_id(params[:id])

      user.update_attributes(deleted: true, email: 'deleted@user.com' + user.id.to_s, user_name: 'deleted', first_name: 'deleted', last_name: 'deleted')
    end
    #  conditions = {deleted: !true}
    #@users_grid = initialize_grid(User,  :conditions => conditions,
    #                              :include => [:roles, :user_settings],
    #                              per_page: 20
    #)

    messages = Message.where(:sender_id=>user.id)
    notifications = Notification.where(message_id: messages.map{|mes| mes.id})
    messages2 = Message.where(:receiver_id=>user.id)
    notifications2 = Notification.where(message_id: messages.map{|mes| mes.id})
    messages.destroy_all
    messages2.destroy_all
    notifications.destroy_all
    notifications2.destroy_all
    respond_to do |format|
      #format.js
      format.json { render :json => "Deleted successfully!", status: 200 }
    end
    #redirect_to admin_users_index_path({:delete=>true})
  end
end
