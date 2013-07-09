class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
   @hop_list = current_user ? current_user.hops.all : []
   @hop_tasks = current_user ? current_user.hop_tasks.all : []
  end
end
