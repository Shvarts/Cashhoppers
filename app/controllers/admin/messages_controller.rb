class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!

  def message_history
    @messages = Message.where(:email=>false)
  end

  def email_history
    @emails=Message.find_all_by_email(true)
  end

  def create_email

    params[:message][:author_id]=current_user.id
    params[:message][:email]=true
    @message = Message.new(params[:message])
    if @message.save
      flash[:success]="message has created"
      redirect_to admin_messages_email_tool_path
    else
      flash[:success]="message has not created"
      render admin_messages_email_tool_path
    end
  end

  def create_message
   #render :text=>params
    params[:message][:author_id]=current_user.id
    params[:message][:email]=false
   @message = Message.new(params[:message])
    if @message.save
      flash[:success]="message has created"
      redirect_to admin_messages_message_tool_path
    else
      flash[:success]="message has not created"
      render admin_messages_message_tool_path
    end
  end


  def email_tool
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
    @message= Message.new
    @message.receiver_id=params[:id]  if params[:id]
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

  def send_email
    @user = User.find_by_id(params[:message][:receiver_id])
    file = params[:message][:subject]
    email= UserMailer.send_email_for_select_user(@user, params[:message][:email_author], params[:message][:subject], params[:message][:email_text], file)
    render :text => email
  end


end
