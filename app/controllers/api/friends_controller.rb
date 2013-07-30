class Api::FriendsController < Api::ApplicationController

  before_filter :load_friend, only: [:send_request, :accept_request, :decline_request, :cancel_request, :delete_friend]

  def get_friends
    @friends = @current_user.friends
    if @friends.length == 0
      bad_request ['You have no friends.'], 406
    end
  end

  def get_requested_friends
    @requested_friends = @current_user.requested_friends
    if @requested_friends.length == 0
      bad_request ['You have no friends.'], 406
    end
  end

  def get_pending_friends
    @pending_friends = @current_user.pending_friends
    if @pending_friends.length == 0
      bad_request ['You have no friends.'], 406
    end
  end

  def send_request
    Friendship.request(current_user, @friend)
    Notification.create(user_id: @friend.id, event_type: 'Friend invite')
    render :json => {success: true,
                     info: 'Friend request sent.',
                     status: 200
    }
  end

  def accept_request
    if @current_user.requested_friends.include?(@friend)
      Friendship.accept(@current_user, @friend)
      Notification.create(user_id: @friend.id, event_type: 'Friend invite accept')
      render :json => {success: true,
                       info: "Friendship with user #{@friend.id} accepted!",
                       status: 200
      }
    else
      bad_request ["No friendship request from user with id #{@friend.id}."], 406
    end
  end

  def decline_request
    if @current_user.requested_friends.include?(@friend)
      Friendship.breakup(@current_user, @friend)
      render :json => {success: true,
                       info: "Friendship with user #{@friend.id} declined!",
                       status: 200
      }
    else
      bad_request ["No friendship request from user with id #{@friend.id}."], 406
    end
  end

  def cancel_request
    if @current_user.pending_friends.include?(@friend)
      Friendship.breakup(@current_user, @friend)
      render :json => {success: true,
                       info: "Friendship request to user #{@friend.id} canceled!",
                       status: 200
      }
    else
      bad_request ["No request for friendship with #{@friend.id}"], 406
    end
  end

  def delete_friend
    if @current_user.friends.include?(@friend)
      Friendship.breakup(@current_user, @friend)
      render :json => {success: true,
                       info: "Friendship with user #{@friend.id} deleted!",
                       status: 200
      }
    else
      bad_request ["You aren't friends with #{@friend.id}"], 406
    end
  end

  private

  def load_friend
    @friend = User.where(:id => params[:friend_id]).first if params['friend_id']
    unless @friend
      bad_request ["Can't find user by id #{params['friend_id']}"], 406
    end
  end

end
