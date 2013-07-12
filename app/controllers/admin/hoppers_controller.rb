class Admin::HoppersController < ApplicationController
  def find_hopper
    @users = User.all
  end

  def hopper_list
    @users = User.all

  end

  def search_hopper
    @user=Hopper.search(params[:id],params[:name], :id, :user_name).first


    render 'admin/hoppers/find_hopper'
  end

  def search_hoppers
    @user = Hopper.search(params[:hop_id],params[:zip], :hop_id, :zip)
    @id = []

      for i in @user do
        @id<< i.id
      end

    render 'admin/hoppers/hopper_list'
  end



end
