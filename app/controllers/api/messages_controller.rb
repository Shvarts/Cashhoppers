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
  end

end
