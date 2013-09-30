class UsersController < ApplicationController
  #before_filter :authenticate_user!


  def profile
    @user = User.find_by_id(params[:id])
    @user = User.find_by_id(current_user.id) if !@user
    @hops = @user.games
    if params[:subscribe]
        user = User.find_by_id(params[:user_id].to_i)
        subscribe = (params[:subscribe]== 'true')?  true :false
        if user.user_settings.nil?
          set = user.build_user_settings(:unsubscribe =>  subscribe)
          set.save
        else
          user.user_settings.update_attributes(:unsubscribe =>  subscribe)
        end
        render :partial => 'subscribe'
    end
  end

  def index

   end


end
