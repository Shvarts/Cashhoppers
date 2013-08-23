class UsersController < ApplicationController
  #before_filter :authenticate_user!


  def profile
    @user = User.find_by_id(params[:id])
    @user = User.find_by_id(current_user.id) if !@user
    @hops = @user.games

  end

  def index
  end


end
