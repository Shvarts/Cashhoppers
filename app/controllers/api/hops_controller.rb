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
                       .and(hops[:close].eq(false))
                       .and(hop_tasks[:id].not_eq(nil))
                       .and(prizes[:id].not_eq(nil))
                       .and((hops[:zip].matches('%'+@current_user.zip+'%')).or(hops[:zip].eq(nil)).or(hops[:zip].eq('')))

    #@hops =  Hop.find_by_sql("SELECT hops.*, IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) AS isnull
    #                          FROM hops
    #                          LEFT JOIN hoppers_hops on hoppers_hops.hop_id = hops.id
    #                          LEFT JOIN hop_tasks ON hop_tasks.hop_id = hops.id
    #                          LEFT JOIN prizes ON prizes.hop_id = hops.id
    #                          WHERE hops.daily = 0 AND close = 0 AND hop_tasks.id IS NOT NULL AND prizes.id IS NOT NULL
    #                              AND ( hops.zip IS NULL OR hops.zip = '')
    #                          GROUP BY hops.id
    #                          ORDER BY  isnull != #{@current_user.id} , hops.created_at DESC
    #                          LIMIT #{params[:per_page].to_i} OFF
    #                              AND ( hops.zip IS NULL OR hops.zip = '')
    #
    #@hops = Hop
    #  .includes(:hop_tasks)
    #  .includes(:prizes)
    #  .includes(:hoppers)
    #  .select('hops.*')
    #  .where(where_conditions)
    #  .group('hops.id')
    #  .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")
    #  .limit(params[:per_page].to_i)
    #  .offset((params[:page].to_i - 1) * params[:per_page].to_i)

    hops_sql = hops
        .project("hops.*,
         hoppers_hops.id AS hoppers_hops_id,
         hoppers_hops.ask_password AS ask_password,
         hoppers_hops.pts AS score,
         (SELECT COUNT(*) FROM hop_tasks WHERE hop_id = hops.id) AS hop_tasks_count,
         (SELECT COUNT(*) FROM hop_tasks LEFT JOIN user_hop_tasks ON user_hop_tasks.hop_task_id = hop_tasks.id AND user_hop_tasks.user_id = #{@current_user.id} WHERE hop_id = hops.id AND user_hop_tasks.id IS NOT NULL) AS user_hop_tasks_count")
        .join(hop_tasks)
        .join(prizes)
        .join(hoppers)
        .join(hoppers_hops, Arel::Nodes::OuterJoin).on(hoppers_hops[:hop_id].eq(hops[:id]).and(hoppers_hops[:user_id].eq(@current_user.id)))
        .where(where_conditions)
        .group('hops.id')
        .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")

        @hops = ActiveRecord::Base.connection.select_all(hops_sql.to_sql + " LIMIT #{params[:per_page].to_i} OFFSET #{(params[:page].to_i - 1) * params[:per_page].to_i}")

    if @hops.blank?
      bad_request(['Hops not found.'], 406)
    else
      render 'regular', content_type: 'application/json'
    end
  end

  def daily
    #@daily_hops = Hop.find_by_sql(["SELECT hops.*
    #                            FROM hops
    #                            LEFT JOIN hop_tasks ON hop_tasks.hop_id = hops.id
    #                            LEFT JOIN prizes ON prizes.hop_id = hops.id
    #                            WHERE hops.daily = 1 AND hop_tasks.id IS NOT NULL AND prizes.id IS NOT NULL
    #                                AND time_start BETWEEN ? AND ? AND close = 0
    #                            GROUP BY hops.id
    #                            ", DateTime.now.beginning_of_day, DateTime.now.end_of_day])

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

    hops_sql = hops
        .project("hops.*,
        hoppers_hops.id AS hoppers_hops_id,
        hoppers_hops.ask_password AS ask_password,
        hoppers_hops.pts AS score,
        (SELECT COUNT(*) FROM hop_tasks WHERE hop_id = hops.id) AS hop_tasks_count,
        (SELECT COUNT(*) FROM hop_tasks LEFT JOIN user_hop_tasks ON user_hop_tasks.hop_task_id = hop_tasks.id AND user_hop_tasks.user_id = #{@current_user.id} WHERE hop_id = hops.id AND user_hop_tasks.id IS NOT NULL) AS user_hop_tasks_count")
        .join(hop_tasks)
        .join(prizes)
        .join(hoppers)
        .join(hoppers_hops, Arel::Nodes::OuterJoin).on(hoppers_hops[:hop_id].eq(hops[:id]).and(hoppers_hops[:user_id].eq(@current_user.id)))
        .where(where_conditions)
        .group('hops.id')
        .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")

        @daily_hops = ActiveRecord::Base.connection.select_all(hops_sql.to_sql + " LIMIT #{params[:per_page].to_i} OFFSET #{(params[:page].to_i - 1) * params[:per_page].to_i}")

    #@daily_hops = Hop
    #  .includes(:hop_tasks)
    #  .includes(:prizes)
    #  .includes(:hoppers)
    #  .select('hops.*')
    #  .where(where_conditions)
    #  .group('hops.id')
    #  .order("IF(hoppers_hops.user_id IS NULL , -1, hoppers_hops.user_id) != #{@current_user.id} , hops.created_at DESC")
    #  .limit(params[:per_page].to_i)
    #  .offset((params[:page].to_i - 1) * params[:per_page].to_i)

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
