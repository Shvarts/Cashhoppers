class Api::MessagesController < Api::ApplicationController

  def send_message_to_friends
    if params[:text].present? && params[:friends].present? && params[:friends].kind_of?(Array)
      errors = []
      params[:friends].each do |friend_id|
        @friend = User.find(friend_id)
        if @friend && Friendship.exists?(@current_user, @friend)
          message = Message.new(text: params[:text], sender_id: @current_user.id, receiver_id: @friend.id, synchronized: false )
          unless message.save
            errors << message.errors
          end
        else
          errors << "Can't find friend with id #{friend_id}."
        end
      end

      respond_to do |format|
        format.json{
          render :json => {success: true,
                           info: 'Message sent successfully.',
                           errors: errors,
                           status: 200
          }
        }
      end
    else
      bad_request ["Bad request parameters."], 406
    end
  end

  def synchronize_messages
    @messages = Message.where(receiver_id: @current_user.id, synchronized: false)
    @messages.each do |message|
      message.update_attribute :synchronized, true
    end
    respond_to do |format|
      format.json{}
    end
  end

  def get_users_messages_thread
    params[:page] ||= 1
    params[:per_page] ||= 10
    @messages = Message.thread @current_user, params[:page], params[:per_page]

    respond_to do |format|
      format.json{
      }
    end
  end

  def messages_history
    params[:page] ||= 1
    params[:per_page] ||= 10
    @friend = User.where(id: params[:friend_id]).first
    if Friendship.exists?(@current_user, @friend)
      @messages = Message.paginate(page: params[:page], per_page: params[:per_page], conditions: {sender_id: [@current_user.id, @friend.id], receiver_id: [@friend.id, @current_user.id]}, order: "created_at ASC")

      respond_to do |format|
        format.json{}
      end
    else
      bad_request ["Can't find friend with id #{params[:friend_id]}."], 406
    end
  end

  def remove_message
    @message = Message.where(id: params[:message_id], sender_id: @current_user.id).first
    if @message
      @message.delete
      respond_to do |format|
        format.json{
          render :json => {success: true,
                           info: 'Message removed successfully.',
                           status: 200
          }
        }
      end
    else
      bad_request ["Can't find message with id #{params[:message_id]}."], 406
    end
  end

end
