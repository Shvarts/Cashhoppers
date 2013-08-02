class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
    if  flash[:notice]== "You updated your account successfully."
      redirect_to user_path(current_user.id)
      flash[:notice] = flash[:notice]
    end
    @user_hop_tasks = UserHopTask.limit(10).order("created_at DESC")
    render :layout=> "home_layout"
  end

  def hoppers_activity
    @user_hop_tasks = UserHopTask.paginate(
      :page => params[:page], :per_page => 10,
      :order => 'created_at DESC')
  end
end
