class Admin::MessagesController < Admin::AdminController

  before_filter :authenticate_user!

  def email_tool
    @tab = 'email_tool'
  end

  def message_tool
    @tab = 'message_tool'
    @message = Message.new
  end

  def email_history
    @tab = 'email_history'
  end

  def message_history
    @tab = 'message_history'
  end

  def message_create
    redirect_to admin_message_tool_path
  end

  def hops_list
    params[:page] ||= 1
    params[:per_page] ||= 7
    @hops = Hop.paginate page: params[:page], per_page: params[:per_page]
    @selected_hops = params[:selected_hops].present? ? params[:selected_hops] : []
    params[:selected_hops] = nil
    render partial: 'hops_list'
  end

  def users_list
    params[:page] ||= 1
    params[:per_page] ||= 7
    @users = User.paginate page: params[:page], per_page: params[:per_page]
    params[:selected_users] = [] unless params[:selected_users].present?
    render partial: 'users_list'
  end

  #def message_history
  #  @tab = 'message_tool'
  #  @messages = Message.where(:email=>false)
  #end
  #
  #def email_history
  #  @tab = 'email_tool'
  #  @emails=Message.find_all_by_email(true)
  #end
  #
  #def create_email
  #     receiver_id = Message.users_from_hop(params[:hopId])  if params[:hopId]
  #     receiver_id = Message.users_from_zip(params[:zipId])   if params[:zipId]
  #     receiver_id = params[:userId]                          if params[:userId]
  #      (params[:email])? email = true : email = false
  #
  #    if ! receiver_id.nil?
  #      n = Message.send_emails_to(params[:message],current_user.id, receiver_id, email)
  #      (email)? flash[:success]=" #{n} emails  have created"  : flash[:success]=" #{n} messages  have created"
  #     else
  #       (email)? flash[:error]=" emails  have  not created" : flash[:error]=" emails  have  not created"
  #    end
  #
  #   (params[:email])? (redirect_to admin_messages_email_tool_path) : (redirect_to admin_messages_message_tool_path)
  #
  #end
  #
  #def email_tool
  #  @tab = 'email_tool'
  #
  #  flash[:id] = Message.create_users_id_list(params[:id_user],flash[:id]) if params[:id_user]
  #
  #  conditions = Message.conditions_for_users(params[:query])
  #  flash[:id] =  flash[:id]
  #
  #  @message= Message.new
  #
  #  @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
  #  render partial: 'users_list' if params[:page] || params[:query]|| params[:id_user]
  #
  #  (params[:id])? (@arr, @arr_id = Message.external_id(params[:id])) : (@arr = @arr_id = [])
  #
  #end
  #
  #def message_tool
  # @tab = 'message_tool'
  #
  # conditions = Message.conditions_for_users(params[:query])
  # @message= Message.new
  # @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )
  #
  # render partial: 'users_list' if params[:page] || params[:query]
  #
  # (params[:id])? (@arr, @arr_id = Message.external_id(params[:id])) : (@arr = @arr_id = [])
  #
  #
  #
  #end
  #
  #def show
  #  @message = Message.find_by_id(params[:id])
  #end
  #
  #def destroy
  #  @message = Message.find_by_id(params[:id])
  #  email = @message.email
  #  @message.destroy
  #
  #  (email)? (redirect_to admin_messages_email_history_path):(redirect_to admin_messages_message_history_path)
  #
  #end
  #
  #
  #
  #def find_hop
  #
  #  conditions = ["name LIKE ? OR name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
  #  @hops = Hop.paginate(page: params[:page], per_page:9, conditions:  conditions)
  #  render :partial=> 'hops_list'
  #
  #
  #
  #
  #end
  #
  #
  #def find_zip
  #
  # conditions = ["zip LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
  #  @zips = User.group(:zip).select(:zip)
  #  @zips = @zips.paginate(:page => 1, :per_page => 9,  conditions:  conditions )
  #
  #  render :partial=> 'zips_list'
  #
  #end

  def sub_layout
    'admin/messages_tabs'
  end

end
