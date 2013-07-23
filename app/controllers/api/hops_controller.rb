class Api::HopsController < Api::ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :daily, :assign, :get_tasks]
  before_filter :load_hop, only: [:assign, :get_tasks, :get_hop_by_id]

  def regular
    params[:page] ||= 1
    params[:per_page] ||= 10
    @hops =  Hop.find_by_sql("SELECT hops.*, hoppers_hops.*, IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) AS isnull
                              FROM hops LEFT JOIN hoppers_hops on hoppers_hops.hop_id = hops.id ORDER BY  isnull != #{@current_user.id} , hops.created_at DESC;")
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

  def get_tasks
    @hop_tasks = @hop.hop_tasks
  end

  def get_hop_by_id
    respond_to do |format|
      format.json{}
    end
  end

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first
    bad_request(['Hop not found.'], 406) unless @hop
  end

end
