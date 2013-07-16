class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!

  def message_history
    @messages = Message.where(:email=>false)
  end

  def email_history
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

    email= UserMailer.send_email_for_select_user(params[:id]).deliver
   # flash[:success]="Email has created"
  #  redirect_to admin_messages_email_tool_path

  end


end
