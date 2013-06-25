#require 'base64'

class Api::SessionsController < Devise::SessionsController
  #skip_before_filter :authenticate_user!, :only => :create

 before_filter :check_api_key

  def sign_up
      if params[:avatar]  
         jpg=params[:avatar]
      
         File.open("public/images/avatars/users/#{params[:avatar_name]}.#{params[:avatar_type]}", 'wb'){ |file| file.write decoded_file = Base64.decode64(jpg) }
      end
      
  
    
    user = User.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name], :user_name => params[:user_name], :zip => params[:zip], :password => params[:password], :password_confirmation => params[:password])
    if user.save
      if params[:email]
        user.avatar_file_name= "#{params[:avatar_name]}.#{params[:avatar_type]}"
        user.avatar_content_type= params[:avatar_type]
      end
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

  def check_api_key
    if Application.where(:api_key => params[:api_key]).blank?
      invalid_login_attempt 'Bad api key'
    end
  end

end
