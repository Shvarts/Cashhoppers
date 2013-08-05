class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home

    #@tasks =  UserHopTask.all.order("created_at DESC")
    collection = ['btn_login_twitter.png','facebook.png','google.png','logo.png' ]
    @pac =[]
    n= 0
    for i in collection
      n = n+1
      if n+1 >   collection.length
        @pac << [i , collection[0],  collection[1], collection[2]]

      elsif n+2 > collection.length
        @pac << [i , collection[n], collection[0],collection[1] ]

      elsif n+3 > collection.length
        @pac << [i , collection[n], collection[n+1],collection[0] ]

      else
        @pac << [i ,collection[n], collection[n +1],collection[n+2]]
      end
    end


    @tasks

    if  flash[:notice]== "You updated your account successfully."
      redirect_to user_path(current_user.id)
      flash[:notice] = flash[:notice]
    end
    @user_hop_tasks = UserHopTask.limit(10).order("created_at DESC")
    puts '------------------------------------------------------'
    puts @user_hop_tasks.inspect
    render :layout=> "home_layout"
  end

  def hoppers_activity
    @user_hop_tasks = UserHopTask.paginate(
      :page => params[:page], :per_page => 10,
      :order => 'created_at DESC')
  end
end
