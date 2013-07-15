class UsersController < ApplicationController
  def profile
    @user= User.find_by_id(params[:id])
  end
end
