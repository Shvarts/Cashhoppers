class PagesController < ApplicationController
  def home
   @hop_list = current_user ? current_user.hops.all : []
   @hop_tasks = current_user ? current_user.hop_tasks.all : []
   @daily_hops = current_user ? current_user.daily_hops.all : []
  end
end
