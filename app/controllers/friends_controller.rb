class FriendsController < ApplicationController

  def friends
    params[:tab] = :friends
    @friends = current_user.friends
  end

  def find_friends
    params[:tab] = :find_friends
    @users = User.paginate(page: params[:page], per_page:10)

    respond_to do |format|
      format.html
      format.js do
          render partial: 'users_list'
      end
    end
  end
end
