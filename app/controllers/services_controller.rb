class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :add_zip]

  def index
    # get all authentication services assigned to the current user
    @services = current_user.services.all
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    @service.destroy

    redirect_to services_path
  end

  def add_zip
    omniauth = request.env['omniauth.auth']
    if omniauth && params[:service]
      service_route = params[:service]
      @service = service_route
      if service_route == 'facebook'
        omniauth['extra']['raw_info']['email'] ? @email =  omniauth['extra']['raw_info']['email'] : @email = ''
        omniauth['extra']['raw_info']['name'] ? @name =  omniauth['extra']['raw_info']['name'] : @name = ''
        omniauth['extra']['raw_info']['id'] ?  @uid =  omniauth['extra']['raw_info']['id'] : @uid = ''
        omniauth['provider'] ? @provider =  omniauth['provider'] : @provider = ''
      elsif service_route == 'twitter'
        @email = ''
        omniauth['extra']['raw_info']['name'] ? @name =  omniauth['extra']['raw_info']['name'] : @name = ''
        omniauth['uid'] ?  @uid =  omniauth['uid'] : @uid = ''
        omniauth['provider'] ? @provider =  omniauth['provider'] : @provider = ''
      else
        render :text => omniauth.to_yaml
      end

      if @uid != '' and @provider != ''
        if !user_signed_in?
          auth = Service.find_by_provider_and_uid(@provider, @uid)
          if auth
            flash[:notice] = 'Signed in successfully via ' + @provider.capitalize + '.'
            sign_in_and_redirect(:user, auth.user)
          end
        else
          auth = Service.find_by_provider_and_uid(@provider, @uid)
          if !auth
            current_user.services.create(:provider => @provider, :uid => @uid, :uname => @name, :uemail => @email)
            flash[:notice] = 'Sign in via ' + @provider.capitalize + ' has been added to your account.'
            redirect_to services_path
          else
            flash[:notice] = service_route.capitalize + ' is already linked to your account.'
            redirect_to services_path
          end
        end
      else
        flash[:error] =  service_route.capitalize + ' returned invalid data for the user id.'
        redirect_to new_user_session_path
      end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
      redirect_to new_user_session_path
    end
  end
  

  def create
    if params[:email] != '' && params[:zip] != ''
      existinguser = User.find_by_email(params[:email])
      if existinguser
        existinguser.services.create(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])
        flash[:notice] = 'Sign in via ' + params[:provider].capitalize + ' has been added to your account ' + existinguser.email + '. Signed in successfully!'
        sign_in_and_redirect(:user, existinguser)
      else
        params[:name] = params[:name][0, 39] if params[:name].length > 39
        user = User.new :email => params[:email], :password => SecureRandom.hex(10), :user_name => params[:name], :zip => params[:zip]
        user.services.build(:provider => params[:provider], :uid => params[:uid], :uname => params[:name], :uemail => params[:email])
        user.skip_confirmation!
        user.save!
        user.confirm!

        flash[:notice] = 'Your account on CommunityGuides has been created via ' + params[:provider].capitalize + '. In your profile you can change your personal information and add a local password.'
        sign_in_and_redirect(:user, user)
      end
    else
      flash[:error] =  params[:provider].capitalize + ' can not be used to sign-up on CommunityGuides as no valid email address and zip code has been provided. Please use another authentication provider or use local sign-up. If you already have an account, please sign-in and add ' + params[:provider] + ' from your profile.'
      redirect_to new_user_session_path
    end
  end

end
