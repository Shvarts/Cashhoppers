class Api::HopsController < Api::ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :daily, :assign, :get_tasks]
  before_filter :load_hop, only: [:assign, :get_tasks]

  def regular
    params[:page] ||= 1
    params[:per_page] ||= 10
    @hops = Hop.paginate(page: params[:page], per_page: params[:per_page], conditions: {daily: false, close: false})
    bad_request(['Hops not found.'], 406) if @hops.blank?
  end

  def daily
    @hops = Hop.paginate(:page => params[:page],
                         per_page: params[:per_page],
                         conditions: ["time_start BETWEEN ? AND ? AND daily = 1 AND close = 0", DateTime.now.beginning_of_day.strftime("%d/%m/%Y %H:%M:%S"), DateTime.now.end_of_day.strftime("%d/%m/%Y %H:%M:%S")])
    if @hops.blank?
      bad_request(['Hops not found.'], 406) if @hops.blank?
    end
  end

  def assign
    if @hop.hoppers.include? @current_user
      bad_request(['User already assigned to this hop.'], 406)
    else
      @hop.assign @current_user
      render :json => {success: true,
                       info: "Assigned to hop successfully!",
                       status: 200
      }
    end
  end

  def get_tasks
    @hop_tasks = @hop.hop_tasks
  end

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first
    bad_request(['Hop not found.'], 406) unless @hop
  end

end
