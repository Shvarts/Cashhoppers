class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
    @user_hop_tasks = UserHopTask.paginate(
      :page => params[:page], :per_page => 10,
      :order => 'created_at DESC')
    if  flash[:notice]== "You updated your account successfully."
      redirect_to user_path(current_user.id)
      flash[:notice] = flash[:notice]
    end

  end
end
