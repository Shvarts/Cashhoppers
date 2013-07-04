class Api::ApplicationController < ApplicationController
  before_filter :check_api_key

  def invalid_login_attempt(errors, status = 200)
    warden.custom_failure!
    render :json => {:errors => errors,  :success => false, :status => status} and return
  end

  protected
  def check_api_key
    if Application.find_by_api_key(params[:api_key]).blank?
      invalid_login_attempt('Bad api key', 401)
    end
  end
end
