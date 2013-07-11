class Admin::HoppersController < ApplicationController
  def find_hopper
    @users = User.all
  end

  def hopper_list
    @users = User.all
  end

  def search_hopper
    search1(params[:id],params[:name], :id, :user_name)
    render 'admin/hoppers/find_hopper'
  end

  def search_hoppers
    search1(params[:hop_id],params[:zip], :hop_id, :zip)

    render 'admin/hoppers/hopper_list'
  end


  def search1( id,name, params_1, params_2)
    if params_1==:hop_id
      params_1=''
    end

    if (!id.blank? && !name.blank?)
      @user = User.where(params_1 => id, params_2 => name).first
    elsif !(id.blank?)
      @user = User.where(params_1=>id).first
    elsif !(name.blank?)
      @user = User.where(params_2 => name).first
    else
      @user=[]
      flash[:not_found]="Not found"
    end

  end
end
