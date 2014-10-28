class ApplicationController < ActionController::Base
  #protect_from_forgery # TODO uncomment after deploy to production server
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def sub_layout
    nil
  end

  def sidebar
    nil
  end


end
