class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
  @user_hop_tasks = UserHopTask.limit(10).order("created_at DESC")
    render :layout=> "home_layout"
  end
end
