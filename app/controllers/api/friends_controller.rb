class Api::FriendsController < ApplicationController

  before_filter :check_api_key
  before_filter :load_friend, only: [:send_request, :accept_request, :decline_request, :cancel_request, :delete_friend]

  def get_friends
    @friends = current_user.friends
    if @friends.length == 0
      render json: { :message => "You have no friends." },  success: true, status: :ok
    end
  end

  def get_requested_friends
    @requested_friends = current_user.requested_friends
    if @requested_friends.length == 0
      render json: { :message => "You have no requested friends." },  success: true, status: :ok
    end
  end

  def get_pending_friends
    @pending_friends = current_user.pending_friends
    if @pending_friends.length == 0
      render json: { :message => "You have no pending friends." },  success: true, status: :ok
    end
  end

  def send_request
    Friendship.request(current_user, @friend)
    render json: { :message => ["Friend request sent."] },  success: true, status: :ok
  end

  def accept_request
    if current_user.requested_friends.include?(@friend)
      Friendship.accept(current_user, @friend)
      flash[:notice] = "Friendship with #{@friend.first_name} accepted!"
      render json: { :message => "Friendship with user #{@friend.id} accepted!" },  success: false, status: :ok
    else
      render json: { :message => "No friendship request from user with id #{@friend.id}." },  success: false, status: :ok
    end
  end

  def decline_request
    if current_user.requested_friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      render json: { :message => "Friendship with user #{@friend.id} declined!" },  success: true, status: :ok
    else
      render json: { :message => "No friendship request from user with id #{@friend.id}." },  success: false, status: :ok
    end
  end

  def cancel_request
    if current_user.pending_friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      render json: { :message => "Friendship request to user #{@friend.id} canceled!" },  success: true, status: :ok
    else
      render json: { :message => "No request for friendship with #{@friend.id}" },  success: false, status: :ok
    end
  end

  def delete_friend
    if current_user.friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      render json: { :message => "Friendship with user #{@friend.id} deleted!" },  success: true, status: :ok
    else
      render json: { :message => "You aren't friends with #{@friend.id}" },  success: false, status: :ok
    end
  end

  private

  def load_friend
    @friend = User.where(:id => params[:friend_id]).first if params['friend_id']
    unless @friend
      invalid_login_attempt("Can't find user by id #{params['friend_id']}", 200)
    end
  end

end
