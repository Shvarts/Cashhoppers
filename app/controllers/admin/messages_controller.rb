class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!

  def message_history
    @messages = Message.where(:email=>false)
  end

  def email_history
    @emails=Message.find_all_by_email(true)
  end

  def create_email


    render :text=>params
    #n = Message.send_emails_to(params[:message],current_user.id, true)
    #flash[:success]=" #{n} emails  have created"
    #redirect_to admin_messages_email_tool_path
  end

  def create_message
    n = Message.send_emails_to(params[:message],current_user.id, false)
    flash[:success]=" #{n} emails  have created"
    redirect_to admin_messages_message_tool_path
  end


  def email_tool
    @select_id = []
    if !params[:id_user].blank?
      @select_id << params[:id_user]
      @select_id << flash[:id]
      @select_id.flatten!
      @select_id.compact!
      @select_id.uniq!
      flash[:id] = @select_id
    end


    params[:id] = flash[:id] if !params[:close].blank?

   puts"----------------------------- #{params}--------------------------------------------"
    puts"----------------------------- #{params}--------------------------------------------"
    puts"----------------------------- #{params}--------------------------------------------"

    @message= Message.new
    @message.receiver_id= params[:id]  if !params[:id].blank?

    conditions = []
    unless params[:query].blank?
 #     conditions = ["first_name LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
      if params[:id]=='true'
        conditions = ["id LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
      else
        conditions = ["zip LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
      end
    end
    @user= User.all
    @zips = []
    for i in @user
      @zips << i.zip
      @zips.uniq!

    end

    @zips = @zips.paginate(:page => 1, :per_page => 9)

    @users = User.paginate(page: params[:page], per_page:9, conditions: conditions )

    @hops = Hop.paginate(page: params[:page], per_page:9, conditions: '')

    #@zips = @zips.paginate(page: params[:page], per_page:9, conditions: '')

   if params[:page] || params[:query]|| params[:id_user]
          render partial: 'users_list'
    end

  end

  def wice_grid
   @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name',
      :include => [:hop]
    )
    render :partial => 'wice_grid'
 end

  def message_tool
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

  def text_tool

  end





end
