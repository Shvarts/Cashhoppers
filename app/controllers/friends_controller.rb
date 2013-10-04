class FriendsController < ApplicationController

  before_filter :setup_friends, except: [:find_friends, :friends]

  def friends
    params[:tab] = :friends
    @friends = current_user.friends
    @requested_friends = current_user.requested_friends
    @pending_friends = current_user.pending_friends
  end

  def find_friends
    params[:tab] = :find_friends

    conditions = {deleted: !true}
    unless params[:query].blank?
      conditions = ["(first_name LIKE ? OR last_name LIKE ? ) AND deleted != 1", "%#{params[:query]}%", "%#{params[:query]}%"]
    end

    @users = User.paginate(page: params[:page], per_page:10, conditions: conditions  )

    respond_to do |format|
      format.text do
        render partial: 'users_list'
      end
      format.html do
      end
    end
  end

  def sub_layout
    'friends/tabs'
  end

# Send a friend request.
# We'd rather call this "request", but that's not allowed by Rails.
  def create_request
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent."
    redirect_to :back
  end

  def accept_request
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.first_name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.first_name}."
    end
    redirect_to :back
  end

  def decline_request
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.first_name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.first_name}."
    end
    redirect_to :back
  end

  def cancel_request
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.first_name}"
    end
    redirect_to :back
  end

  def delete_friend
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.first_name} deleted!"
    else
      flash[:notice] = "You aren't friends with #{@friend.first_name}"
    end
    redirect_to :back
  end

  private

  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

end
