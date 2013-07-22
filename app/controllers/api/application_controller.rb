class Api::ApplicationController < ApplicationController
  # we dont need forgery protection on api calls
  #skip_before_filter :verify_authenticity_token

  skip_before_filter :authenticate_user!
  before_filter :check_api_key
  before_filter :api_authentikate_user

  private

  def check_api_key
    if Application.find_by_api_key(params[:api_key]).blank?
      bad_request('Bad api key', 401)
    end
  end

  def api_authentikate_user
    @session = Session.where(:auth_token => params[:authentication_token]).first
    unless @session
      bad_request ['session invalid or expired'], 401
    else
      @session.update_attributes(updated_at: Time.now)
      @current_user = User.where(id: @session.user_id).first
      unless @current_user
        bad_request ['session invalid or expired'], 401
        @session.destroy
      end
    end
  end

  def bad_request(errors, status = 200)
    warden.custom_failure!
    render :json => {:errors => errors,  :success => false, :status => status} and return
  end


end
