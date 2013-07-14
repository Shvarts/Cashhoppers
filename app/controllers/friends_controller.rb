class FriendsController < ApplicationController

  def friends
    params[:tab] = :friends
    @friends = current_user.friends
  end

  def find_friends
    params[:tab] = :find_friends

    conditions = []
    unless params[:query].blank?
      conditions = ["first_name LIKE ? OR last_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"]
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
end
