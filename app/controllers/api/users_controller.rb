class Api::UsersController < ApplicationController
  respond_to :json

  def index
    params[:page] ||= 1
    params[:per_page] ||= 10
    @users = User.paginate(page: params[:page], per_page: params[:per_page])
    invalid_login_attempt('users not found') if @users.blank?
    respond_to do |format|
      format.json{}
    end
  end

  def get_my_info
    @user = current_user
    respond_to do |format|
      format.json{}
    end
  end

  def get_user_info
    unless params[:user_id] && @user = User.find(params[:user_id])
      invalid_login_attempt('user not found')
    end
  end

end
