class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
    if  flash[:notice]== "You updated your account successfully."
      redirect_to user_path(current_user.id)
      flash[:notice] = flash[:notice]
    end

    tasks_count = 5
    @user_hop_tasks = UserHopTask.limit(tasks_count).order("created_at DESC")
    doublicate_tasks = @user_hop_tasks + @user_hop_tasks
    @tasks_pack = []
    tasks_count.times do |i|
      @tasks_pack << doublicate_tasks[i..(i+3)]
    end

    render :layout=> "home_layout"
  end

  def hoppers_activity
    @user_hop_tasks = UserHopTask.paginate(
      :page => params[:page], :per_page => 10,
      :order => 'created_at DESC')
  end

    def trade_show
  end

  def terms

  end

  def business_level

  end

end
