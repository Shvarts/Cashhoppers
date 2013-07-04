class Api::HopsController < Api::ApplicationController

  def index
    @hops = Hop.regular.paginate(:page => params[:page])
    invalid_login_attempt('hops not found') if @hops.blank?
  end

  def daily
    @hops = Hop.daily.paginate(:page => params[:page])
    invalid_login_attempt('daily hops not found') if @hops.blank?
    render 'api/hops/index'
  end
end
