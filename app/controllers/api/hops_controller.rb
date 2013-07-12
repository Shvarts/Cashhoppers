class Api::HopsController < Api::ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :daily, :get_hop_tasks]

  def index
    params[:page] ||= 1
    params[:per_page] ||= 10
    @hops = Hop.regular.paginate(page: params[:page], per_page: params[:per_page])
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

  def get_hop_tasks
    @hop = Hop.where(:id => params[:hop_id]).first
    invalid_login_attempt('hops not found') unless @hop
    @hop_tasks = @hop.hop_tasks
  end

end
