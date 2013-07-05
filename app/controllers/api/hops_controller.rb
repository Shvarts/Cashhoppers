class Api::HopsController < Api::ApplicationController

  def index
    @hops = Hop.regular.paginate(:page => params[:page])
    invalid_login_attempt('hops not found') if @hops.blank?
  end

  def daily
    @hops = Hop.daily.paginate(:page => params[:page])
    if @hops.blank?
      invalid_login_attempt('daily hops not found')
    else
      render 'api/hops/index'
    end
  end
end
