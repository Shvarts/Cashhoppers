class PagesController < ApplicationController
  def home
   @hop_list = current_user ? current_user.hops.all : []
   @hop_tasks = current_user ? current_user.hop_tasks.all : []
  end
end
