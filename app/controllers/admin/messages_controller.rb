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
    n = Message.send_emails_to(params[:message],current_user.id)
    flash[:success]=" #{n} emails  have created"
    redirect_to admin_messages_email_tool_path
  end

  def create_message
    n = Message.send_messages_to(params[:message],current_user.id)
    flash[:success]=" #{n} emails  have created"
    redirect_to admin_messages_message_tool_path
  end


  def email_tool
    @tab = 'email_tool'
    @message= Message.new
    @message.receiver_id=params[:id]  if !params[:id].blank?
  #  @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name')
  end

  def wice_grid
   @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name',
      :include => [:hop]
    )
    render :partial => 'wice_grid'
 end

  def message_tool
    @tab = 'message_tool'
    @message= Message.new
    @message.receiver_id=params[:id]  if params[:id]
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

  def close_grid
    if params[:close].to_i==0
      session[:close]=0
      session.delete('close')
    else
     session[:close]=params["close"]
    end
    redirect_to 'email_tool'
  end

  def sub_layout
    'admin/messages_tabs'
  end


end
