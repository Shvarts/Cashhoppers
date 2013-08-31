class Api::SessionsController < Api::ApplicationController

  skip_before_filter :api_authentikate_user
  before_filter :api_authentikate_user, except: [:create, :sign_in_via_service, :sign_up, :confirm_registration, :service_exist, :reset_password]

  def sign_up
    user = User.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name], :user_name => params[:user_name], :zip => params[:zip],
                    :password => params[:password], :password_confirmation => params[:password], :avatar => params[:avatar])

    if user.save
      render :json => {:success=>true,
                       :info => 'Check your email and confirm registration.',
                       :data => {:user => user},
                       :status => 200
      }
    else
      bad_request user.errors.full_messages, 200
    end
  end

  def confirm_registration
    user = User.find_by_confirmation_token params[:confirmation_token]
    if params[:confirmation_token] != '' && user
      user.confirmation_token = nil
      user.confirmed_at = Time.now
      user.save
      render :json => {:success=>true,
                       :info => 'Confirmation successfully.',
                       :data => {email: user.email},
                       :status => 200
      }
    else
      bad_request ['Bad confirmation token'], 406
    end
  end

  def create
    @user = User.find_for_database_authentication(:email=>params[:email])

    if @user && @user.valid_password?(params[:password])
      session = create_session @user
      render :json => {:success=>true,
                       :info => "Logged in",
                       :data => {authentication_token: session[:auth_token], email: @user.email},
                       :status => 200
      }
    else
      bad_request ['Invalid login or password'], 401
    end
  end

  def destroy
    session = CashHoppers::Application::SESSIONS.select{|session|
      session if session[:auth_token] == params[:authentication_token]
    }.first
    if session
      destroy_session session
      render :json => { :success => true,  :info => "Logged out", :status => 200 }
    else
      bad_request ['invalid login or password'], 401
    end
  end

  def sign_in_via_service
    #api_key, email, name, uid, provider
    auth = Service.find_by_provider_and_uid(params[:provider], params[:uid])
    if auth
      session = create_session auth.user
      render :json => {success: true,
                       info: 'Signed in successfully via ' + params[:provider].capitalize,
                       data: {authentication_token: session[:auth_token], email: auth.user},
                       status: 200
      }
    else
      if params[:email] != ''
        existinguser = User.find_by_email(params[:email])
        if existinguser
          existinguser.services.create(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])
          session = create_session existinguser
          render :json => {success: true,
                           info: 'Sign in via ' + params[:provider].capitalize + '. ' + params[:provider].capitalize + ' has been added to your account ' + existinguser.email + '. Signed in successfully!',
                           data: {authentication_token: session[:auth_token], :user => existinguser},
                           status: 200
          }
        else
          params[:name] = params[:name][0, 39] if params[:name].length > 39

          user = User.new :email => params[:email], :password => SecureRandom.hex(10), :user_name => params[:name], :zip => params[:zip]

          user.services.build(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])

          user.skip_confirmation!
          if user.save
            user.confirm!
            session = create_session user
            render :json => {success: true,
                             info: 'Your account has been created via ' + params[:provider].capitalize,
                             data: {authentication_token: session[:auth_token], :user => user},
                             status: 200
            }
          else
            destroy_session session
            bad_request user.errors, 406
          end
        end
      else
        destroy_session session
        bad_request ["Email can't be blank."], 401
      end
    end
  end

  def service_exist
    if params[:provider] && params[:uid]
      auth = Service.find_by_provider_and_uid(params[:provider], params[:uid])
      render :json => {
        user_exist: (auth)? true : false
      }
    else
      bad_request ['Bad params.'], 200
    end
  end

  def set_android_registration_id
    if params[:registration_id].present?
      @session[:device] = 'Android'
      @session[:device_token] = params[:registration_id]
      render :json => {
        message: 'Push notifications enabled.'
      }
    else
      bad_request ['Bad params.'], 406
    end
  end

  def reset_password
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.send_reset_password_instructions
      render :json => {
        message: 'Confirmation instructions sended. Please check your email.'
      }
    else
      bad_request ['Cant find user by email.'], 406
    end
  end

  private

  def create_session user
    range = [*'0'..'9', *'a'..'z', *'A'..'Z']
    session = {user_id: user.id, auth_token: Array.new(30){range.sample}.join, updated_at: Time.now}
    if params[:device].present? && params[:device_token].present?
      session[:device] = params[:device]
      session[:device_token] = params[:device_token]
    end
    CashHoppers::Application::SESSIONS << session
    CashHoppers::Application::USERS << user
    session
  end

  def destroy_session session
    CashHoppers::Application::USERS.delete_if{|user| user.id < session[:user_id]}
    CashHoppers::Application::SESSIONS.delete session
  end

end
