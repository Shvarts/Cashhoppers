class Api::UsersController < ApplicationController
  respond_to :json
  before_filter :find_user, only: [:get_user_info]
  before_filter :filter_attributes, only: [:update_profile]

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

  end

  def update_profile
    respond_to do |format|
      puts '----------------------------'
      puts @attributes
      puts '----------------------------'
      if current_user.update_attributes(@attributes)
        format.json {render :json => {success: true, message: 'profile successfully updated.'} }
      else
        format.json {render :json => current_user.errors.to_json }
      end
    end
    #
    #@user = User.find(current_user.id)
    #successfully_updated = if needs_password?(@user, params)
    #                         @user.update_with_password(params[:user])
    #                       else
    #                         params[:user].delete(:current_password)
    #                         @user.update_without_password(params[:user])
    #                       end
    #
    #if successfully_updated
    #  set_flash_message :notice, :updated
    #  sign_in @user, :bypass => true
    #  redirect_to after_update_path_for(@user)
    #else
    #  render "edit"
    #end
  end

  private

  def find_user
    unless params[:user_id] && @user = User.find(params[:user_id])
      invalid_login_attempt('user not found')
    end
  end

  def filter_attributes
    @attributes = {}
    unless params[:first_name].blank?
      @attributes[:first_name] = params[:first_name]
    end
    unless params[:last_name].blank?
      @attributes[:last_name] = params[:last_name]
    end
    unless params[:user_name].blank?
      @attributes[:user_name] = params[:user_name]
    end
    unless params[:zip].blank?
      @attributes[:zip] = params[:zip]
    end
    unless params[:contact].blank?
      @attributes[:contact] = params[:contact]
    end
    unless params[:phone].blank?
      @attributes[:phone] = params[:phone]
    end
    unless params[:bio].blank?
      @attributes[:bio] = params[:bio]
    end
    unless params[:twitter].blank?
      @attributes[:twitter] = params[:twitter]
    end
    unless params[:facebook].blank?
      @attributes[:facebook] = params[:facebook]
    end
    unless params[:google].blank?
      @attributes[:google] = params[:google]
    end
    unless params[:password].blank?
      @attributes[:password] = params[:password]
      @attributes[:password_confirmation] = params[:password_confirmation]
    end
    unless params[:avatar].blank?
      @attributes[:avatar] = params[:avatar]
    end
  end

end
