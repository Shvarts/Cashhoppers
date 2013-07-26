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
    #SELECT
    #users.id AS sender_id, users.avatar_file_name AS sender_avatar_file_name, users.first_name AS sender_first_name, users.last_name AS sender_last_name, users.user_name AS sender_user_name,
    #                                                                                                                                                                         last_message.text AS last_message_text, last_message.id AS last_message_id
    #FROM users
    #LEFT JOIN (SELECT messages.* FROM messages WHERE messages.receiver_id = 1 ORDER BY messages.created_at DESC LIMIT 1) AS last_message ON last_message.sender_id = users.id
    #WHERE users.id IN (SELECT friendships.friend_id FROM friendships WHERE friendships.user_id = 1)
    #;
    @friends = @current_user.friends
    respond_to do |format|
      format.json{
      }
    end
  end

end
