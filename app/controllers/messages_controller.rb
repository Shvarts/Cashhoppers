class MessagesController < ApplicationController

  def friends_list
    @messages = Message.thread current_user
  end

  def friend_messages
    @friend = User.where(id: params[:friend_id]).first
    if @friend && Friendship.exists?(current_user, @friend)
      params[:page] ||= 1
      params[:per_page] ||= 15
      @messages = Message.paginate(page: params[:page],
                                   per_page: params[:per_page],
                                   conditions: {sender_id: [current_user.id, @friend.id], receiver_id: [@friend.id, current_user.id]},
                                   order: "created_at DESC")
      .reverse
    else
      redirect_to messages_friends_list_path, flash: { error: 'Can\'t find user by id or you are not friends.'}
    end
  end

end
