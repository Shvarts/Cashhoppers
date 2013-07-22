class Admin::MessagesController < Admin::AdminController
  before_filter :authenticate_user!

  def message_history
    @tab = 'message_tool'
    @messages = Message.where(:email=>false)
  end

  def email_history
    @tab = 'email_tool'
    @emails=Message.find_all_by_email(true)
  end

  def create_email

     if flash[:id]
        params[:message][:receiver_id] = flash[:id]
        (params[:email])? email = true : email = false
        n = Message.send_emails_to(params[:message],current_user.id, email)
        flash[:success]=" #{n} emails  have created"
        flash[:success]=" #{n} messages  have created"  if  !email
     else
        flash[:success]=" emails  have  not created"
        flash[:success]=" emails  have  not created"  if  !email
     end

     if  email
       redirect_to admin_messages_email_tool_path
     else
       redirect_to admin_messages_message_tool_path
     end
  end




  def email_tool
    @tab = 'email_tool'
    flash[:id] = params[:id] if params[:id]
    flash[:id] = Message.create_users_id_list(params[:id_user],flash[:id]) if params[:id_user]

    conditions = Message.conditions_for_users(params[:query])
    flash[:id] =  flash[:id]

    @message= Message.new

    @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
    render partial: 'users_list' if params[:page] || params[:query]|| params[:id_user]


  end

  def message_tool
    @tab = 'message_tool'
    flash[:id] = Message.create_users_id_list(params[:id_user],flash[:id]) if params[:id_user]

    conditions = Message.conditions_for_users(params[:query])
    flash[:id] =  flash[:id]
    @message= Message.new

    @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
    render partial: 'users_list' if params[:page] || params[:query]|| params[:id_user]




  end

  def show
    @message = Message.find_by_id(params[:id])
  end

  def destroy
    @message = Message.find_by_id(params[:id])
    email = @message.email
    @message.destroy
    if !email
      redirect_to admin_messages_message_history_path
    else
      redirect_to admin_messages_email_history_path
    end
  end


  def sub_layout
    'admin/messages_tabs'
  end

  def find_hop

    flash[:id] = Message.create_hoppers_id_arr(params[:id_hop])
    conditions = ["name LIKE ? OR name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @hops = Hop.paginate(page: params[:page], per_page:9, conditions:  conditions)
    render :partial=> 'hops_list'



  end


  def find_zip

    flash[:id]= Message.create_user_id_arr_by_zip(params[:zip])
    conditions = ["zip LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
    @zips = User.group(:zip).select(:zip)
    @zips = @zips.paginate(:page => 1, :per_page => 9,  conditions:  conditions )

    render :partial=> 'zips_list'

  end

end
