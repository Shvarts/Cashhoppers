require 'base64'

class Api::SessionsController < Devise::SessionsController
  #skip_before_filter :authenticate_user!, :only => :create

  def sign_up
    params[:avatar]=Base.decode64(params[:avatar])
    user = User.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name], :user_name => params[:user_name], :zip => params[:zip], :password => params[:password], :avatar => params[:avatar], :password_confirmation => params[:password])
    if user.save
      user.ensure_authentication_token!
      render :json => {:authentication_token => user.authentication_token, :success => true , :user => user}, :status => :created ,  :success => true
    else
      invalid_login_attempt user.errors
    end
  end
  
  def create
    user = User.find_for_database_authentication(:email => params[:email])
    if user && user.valid_password?(params[:password])
      user.ensure_authentication_token!  # make sure the user has a token generated
      render :json => { :authentication_token => user.authentication_token, :success => true ,:user => user }, :status => :created ,  :success => true
    else
      invalid_login_attempt :errors => ["Invalid login or password."]
    end
  end

  def destroy
    # expire auth token
    user = User.where(:authentication_token => params[:authentication_token]).first
    if user
      user.reset_authentication_token!
      render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
    else
      invalid_login_attempt :errors => ["Bad token."]
    end
  end

  private

  def invalid_login_attempt errors
    warden.custom_failure!
    render :json => {:errors => errors,  :success => false, :status => :unauthorized}.to_json
  end
end
