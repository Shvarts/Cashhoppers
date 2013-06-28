class PagesController < ApplicationController
  def home
    @hop_list=current_user.hops.all
  end
end
