class MessagesController < ApplicationController

  def friends_list
    @messages = current_user.friends.all


  end

  def friend_messages
    puts"----------------#{params}-----------"
    @friend = User.where(id: params[:friend_id]).first
    if @friend && Friendship.exists?(current_user, @friend)
      params[:page] ||= 1
      params[:per_page] ||= 15
      @messages = Message.paginate(page: params[:page],
                                   per_page: params[:per_page],
                                   conditions: {sended: true, sender_id: [current_user.id, @friend.id], receiver_id: [@friend.id, current_user.id]},
                                   order: "created_at ASC")
      @last_sync_date = Time.now
    else
      redirect_to messages_friends_list_path, flash: { error: 'Can\'t find user by id or you are not friends.'}
    end
  end

  def synchronize
    @friend = User.new(id: params[:friend_id], first_name: params[:friend_first_name], last_name: params[:friend_last_name])
    sync_time = DateTime.strptime(params[:last_sync_date], '%Y-%m-%d %H:%M:%S %z')
    ids = [current_user.id, @friend.id]
    @messages = CashHoppers::Application::MESSAGES.select{|message|
      message if (message.created_at > sync_time &&
          ids.include?(message.sender_id)&&
          ids.include?(message.receiver_id)
      )}
    @last_sync_date = Time.now
    if @messages.blank?
      render :text=> 'no messages'
    else
      render partial: 'messages'
    end
  end

  def send_message
    Message.create(sender_id: current_user.id, receiver_id: params[:friend_id], text: params[:text])
    render text: 'ok'
  end

end
