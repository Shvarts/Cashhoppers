class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def sub_layout
    nil
  end

  private
  def invalid_login_attempt(errors, status = 200)
    warden.custom_failure!
    render :json => {:errors => errors,  :success => false, :status => status} and return
  end

  def check_api_key
    if Application.find_by_api_key(params[:api_key]).blank?
      invalid_login_attempt('Bad api key', 401)
    end
  end

end
