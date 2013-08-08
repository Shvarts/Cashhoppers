class Admin::MessagesController < Admin::AdminController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def email_tool
    @tab = 'email_tool'
    @email = EmailAlert.new
  end

  def message_tool
    @tab = 'message_tool'
    @message = Message.new
  end

  def email_history
    @tab = 'email_history'
    params[:page] ||= 1
    params[:per_page] ||= 20
    @messages_grid = initialize_grid(EmailAlert, include: [:receiver], per_page: params[:per_page], :conditions => {sender_id: nil},
                                     :order => 'created_at',
                                     :order_direction => 'desc')
  end

  def message_history
    params[:page] ||= 1
    params[:per_page] ||= 20
    @tab = 'message_history'
    @messages_grid = initialize_grid(Message, include: [:receiver], per_page: params[:per_page], :conditions => {sender_id: nil},
                                     :order => 'created_at',
                                     :order_direction => 'desc')
  end

  def message_create
    params[:zip_codes] = [-1] unless params[:zip_codes].present?
    params[:users_ids] = [-1] unless params[:users_ids].present?
    params[:hops_ids] = [-1] unless params[:hops_ids].present?

    @users = User.find_by_sql("
      SELECT users.* FROM users LEFT JOIN hoppers_hops ON hoppers_hops.user_id = users.id
      WHERE users.id IN (#{params[:users_ids].join(', ')}) OR users.zip IN (#{params[:zip_codes].join(', ')}) OR hoppers_hops.hop_id IN (#{params[:hops_ids].join(', ')});
    ")

    @message = nil
    @users.each do |user|
      message_data = params[:message]
      message_data[:receiver_id] = user.id
      message_data[:synchronized] = 0
      message = Message.new(message_data)
      unless message.save
        @message = message
        break;
      end
    end

    if @message
      render action: 'message_tool'
    else
      redirect_to admin_messages_message_tool_path , notice: 'Messages was successfully sended.'
    end

  end

  def email_create
    params[:zip_codes] = [-1] unless params[:zip_codes].present?
    params[:users_ids] = [-1] unless params[:users_ids].present?
    params[:hops_ids] = [-1] unless params[:hops_ids].present?

    @users = User.find_by_sql("
      SELECT users.* FROM users LEFT JOIN hoppers_hops ON hoppers_hops.user_id = users.id
      WHERE users.id IN (#{params[:users_ids].join(', ')}) OR users.zip IN (#{params[:zip_codes].join(', ')}) OR hoppers_hops.hop_id IN (#{params[:hops_ids].join(', ')});
    ")
    @email = nil
    @messages = []
    @users.each do |user|
      message_data = params[:email_alert]
      message_data[:receiver_id] = user.id
      message = EmailAlert.new(message_data)
      @messages << message
      unless message.valid?
        @email = message
        break
      end
    end

    @email = EmailAlert.new if @users.blank?
    if @email || @users.blank?
      flash[:error] = 'Receivers not selected.'
      render action: 'email_tool'
    else
      @messages.each{|m| m.save}

      UserMailer.email_alert(@users.map{|u| u.email}, EmailAlert.new(params[:email_alert]), params[:file]).deliver
      redirect_to admin_messages_email_tool_path , notice: 'Emails was successfully sended.'
    end

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

  def destroy_message
    @message = Message.find_by_id(params[:id])
    @message.destroy
    redirect_to admin_messages_message_history_path, notice:"Message was succesfully removed."
  end

  def sub_layout
    'admin/messages_tabs'
  end

end
