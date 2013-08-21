class PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  layout "home_layout", :only => [:trade_show, :terms, :business_level ]

  def home

    tasks_count = 5
    @user_hop_tasks = UserHopTask.limit(tasks_count).order("created_at DESC")
    doublicate_tasks = @user_hop_tasks + @user_hop_tasks
    @tasks_pack = []
    tasks_count.times do |i|
      @tasks_pack << doublicate_tasks[i..(i+3)]
    end

    if  flash[:notice]== "You updated your account successfully."
      redirect_to user_path(current_user.id)
      flash[:notice] = flash[:notice]
    elsif flash[:notice]== "Signed in successfully." || flash[:notice]== 'Your account was successfully confirmed. You are now signed in.'
      flash[:notice] = flash[:notice]
      if ! User.user?(current_user)
        redirect_to admin_index_path, :layout=> "home_layout"
      else
        redirect_to users_index_path, :layout=> "home_layout"
      end
    else
      render :layout=> "home_layout"
    end

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
