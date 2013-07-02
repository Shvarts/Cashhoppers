class Api::SessionsController < Devise::SessionsController
  #skip_before_filter :authenticate_user!, :only => :create

 before_filter :check_api_key

  def sign_up

    if params[:base64avatar] && params[:avatar_content_type] && params[:avatar_original_filename]
      decoded_data = Base64.decode64(params[:base64avatar])

      data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end

      data.content_type = params[:avatar_content_type]
      data.original_filename = File.basename(params[:avatar_original_filename])

      params[:avatar] = data
    end

    user = User.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name], :user_name => params[:user_name], :zip => params[:zip],
                    :password => params[:password], :password_confirmation => params[:password], :avatar => params[:avatar])

    if user.save
      render :json => {:message => 'Check your email and confirm registration.', :success => true , :user => user}, :status => :created ,  :success => true
    else
      invalid_login_attempt user.errors
    end
  end

  def confirm_registration
    user = User.find_by_confirmation_token params[:confirmation_token]
    if params[:confirmation_token] != '' && user
      user.confirmation_token = nil
      user.confirmed_at = Time.now
      user.save
      render :json => {:message => 'Confirmation successfully.', :success => true}, :status => :confirmed ,  :success => true
    else
      invalid_login_attempt :errors => ['Bad confirmation token']
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

  def sign_in_via_service
    #api_key, email, name, uid, provider
    auth = Service.find_by_provider_and_uid(params[:provider], params[:uid])
    if auth
      auth.user.ensure_authentication_token!
      render :json => {:message => 'Signed in successfully via ' + params[:provider].capitalize + '.', :authentication_token => auth.user.authentication_token, :success => true ,:user => auth.user },
             :status => :created ,  :success => true
    else
      if params[:email] != ''
        existinguser = User.find_by_email(params[:email])
        if existinguser
          existinguser.services.create(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])
          existinguser.ensure_authentication_token!
          render :json => {:message => 'Sign in via ' + params[:provider].capitalize + '. ' + params[:provider].capitalize + ' has been added to your account ' + existinguser.email + '. Signed in successfully!',
                           :authentication_token => user.authentication_token, :success => true, :user => user }, :status => :created ,  :success => true
        else
          params[:name] = params[:name][0, 39] if params[:name].length > 39

          user = User.new :email => params[:email], :password => SecureRandom.hex(10), :user_name => params[:name], :zip => params[:zip]

          user.services.build(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])

          user.skip_confirmation!
          if user.save
            user.confirm!
            user.ensure_authentication_token!
            render :json => {:message => 'Your account has been created via ' + params[:provider].capitalize,
                             :authentication_token => user.authentication_token, :success => true ,:user => user }, :status => :created ,  :success => true
          else
            invalid_login_attempt :errors => user.errors.to_json
          end
        end
      else
        invalid_login_attempt :errors => ["Email can't be blank."]
      end
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
