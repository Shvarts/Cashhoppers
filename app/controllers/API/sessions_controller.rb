class Api::SessionsController < Devise::SessionsController
  #skip_before_filter :authenticate_user!, :only => :create

  def sign_up
    user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password])
    if user.save
      user.ensure_authentication_token!
      render :json => {:authentication_token => user.authentication_token, :user => user}, :status => :created
    else
      render :json => user.errors.to_json
    end
  end
  
  def create
    #user = User.find_for_database_authentication(:email => params[:email])
    #
    #if user && user.valid_password?(params[:password])
    #  user.ensure_authentication_token!  # make sure the user has a token generated
    #  render :json => { :authentication_token => user.authentication_token, :user => user }, :status => :created
    #else
    #  return invalid_login_attempt
    #end
  end

  def destroy
    ## expire auth token
    #user = User.where(:authentication_token => params[:authentication_token]).first
    #user.reset_authentication_token!
    #render :json => { :message => ["Session deleted."] },  :success => true, :status => :ok
  end

  private

  def invalid_login_attempt
    warden.custom_failure!
    render :json => { :errors => ["Invalid email or password."] },  :success => false, :status => :unauthorized
  end
end
