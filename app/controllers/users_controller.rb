class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @user = User.find_by_id(params[:id])

    @hops = @user.games
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])


      if @user.update_attributes(params[:user])
        sign_in_and_redirect(@user, user_path(@user))

      else
        render 'edit'
      end




  end


end
