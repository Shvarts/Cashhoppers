class Api::HopsController < Api::ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :daily, :assign, :get_tasks, :disable_password]
  before_filter :load_hop, only: [:assign, :get_tasks, :get_hop_by_id, :score, :prizes]

  def regular
    params[:page] ||= 1
    params[:per_page] ||= 10

    hops = Hop.arel_table
    hop_tasks = HopTask.arel_table
    prizes = Prize.arel_table
    hoppers = User.arel_table
    hoppers_hops = HoppersHops.arel_table

    where_conditions = hops[:daily].eq(false)
                       .and(hops[:time_end].gteq(Time.now))
                       .and(hops[:close].eq(false))
                       .and(hop_tasks[:id].not_eq(nil))
                       .and(prizes[:id].not_eq(nil))
                       .and((hops[:zip].matches('%'+@current_user.zip+'%')).or(hops[:zip].eq(nil)).or(hops[:zip].eq('')))

    @hops = Hop
      .includes(:hop_tasks)
      .includes(:prizes)
      .includes(:hoppers)
      .select('hops.*')
      .where(where_conditions)
      .group('hops.id')
      .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")
      .limit(params[:per_page].to_i)
      .offset((params[:page].to_i - 1) * params[:per_page].to_i)

    if @hops.blank?
      bad_request(['Hops not found.'], 406)
    else
      render 'regular', content_type: 'application/json'
    end
  end

  def daily
    #.joins("LEFT OUTER JOIN `hoppers_hops` ON `hoppers_hops`.`hop_id` = `hops`.`id`")
    params[:page] ||= 1
    params[:per_page] ||= 10

    hops = Hop.arel_table
    hop_tasks = HopTask.arel_table
    prizes = Prize.arel_table
    hoppers = User.arel_table
    hoppers_hops = HoppersHops.arel_table

    where_conditions = hops[:daily].eq(true)
      .and(hops[:close].eq(false))
      .and(hop_tasks[:id].not_eq(nil))
      .and(prizes[:id].not_eq(nil))
      .and((hops[:zip].matches('%'+@current_user.zip+'%')).or(hops[:zip].eq(nil)).or(hops[:zip].eq('')))
      .and(hops[:time_start].in(DateTime.now.beginning_of_day..DateTime.now.end_of_day))

    @daily_hops = Hop
      .includes(:hop_tasks)
      .includes(:prizes)
      .includes(:hoppers)
      .select('hops.*')
      .where(where_conditions)
      .group('hops.id')
      .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")
      .limit(params[:per_page].to_i)
      .offset((params[:page].to_i - 1) * params[:per_page].to_i)

    if @daily_hops.blank?
      bad_request(['Daily hops not found.'], 406)
    else
      render 'daily', content_type: 'application/json'
    end
  end

  def get_tasks
    @hop_tasks = @hop.hop_tasks
    render 'get_tasks', content_type: 'application/json'
  end

  def get_hop_by_id
    render 'get_hop_by_id', content_type: 'application/json'
  end

  def score
    respond_to do |format|
      format.json{
        render :json => {success: true,
                         score: @hop.score(@current_user),
                         hoppers_count: @hop.hoppers.count,
                         rank: @hop.rank(@current_user),
                         status: 200
        }
      }
    end
  end

  def yesterdays_winner
    hop = Hop.get_daily_by_date DateTime.now - 1.day
    if hop
      prize = hop.prizes.order("place ASC").first
      if prize && prize.user_id
        respond_to do |format|
          format.json{
            render :json => {success: true,
                             winner_id: prize.user_id,
                             winners_first_name: prize.user.first_name,
                             winners_last_name: prize.user.last_name,
                             winners_avatar: prize.user.avatar.url,
                             score: prize.pts,
                             hoppers_count: hop.hoppers.count,
                             rank: prize.place,
                             hop_id: hop.id,
                             hop_name: hop.name,
                             cost: prize.cost,
                             status: 200
            }
          }
        end
      else
        bad_request(['Missing winner for yesterday\'s hop.'], 406)
      end
    else
      bad_request(['Missing yesterday\'s hop.'], 406)
    end
  end

  def prizes
    @prizes = @hop.prizes
    render 'prizes', content_type: 'application/json'
  end

  def disable_password
    @hop = Hop.find_by_id(params[:hop_id])
    if params[:password] == @hop.code
      @hop.disable_password @current_user
      respond_to do |format|
        format.json{
          render :json => {success: true,
            info: 'Password successfully disabled.',
            status: 200
          }
        }
      end
    else
      bad_request(['Wrong password.'], 200)
    end
  end

  private

  def load_hop
    @hop = Hop.where(:id => params[:hop_id]).first   #.includes(:hop_task).where("hop_tasks.id IS NOT NULL")
    bad_request(['Hop not found.'], 406) unless @hop
  end

end
