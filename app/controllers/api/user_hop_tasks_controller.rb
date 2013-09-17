class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json
  before_filter :load_hop_task, only: [:create, :get_hop_task_by_id, :notify_by_share]
  before_filter :load_user_hop_task, only: [:like, :likes_count, :comment, :comments, :get_user_hop_task_by_id]

  def create
    if UserHopTask.where(user_id: @current_user.id, hop_task_id: @hop_task.id).first
      bad_request(['Hop task already comleted.'], 200)
    elsif !@hop_task || !@hop_task.hop
      bad_request(['Can\'t find hop by hop task.'], 406)
    elsif !@hop_task.hop.free? && !@hop_task.hop.assigned?(@current_user)
      bad_request(['Hop is paid.'], 406)
    elsif @hop_task && @hop_task.hop && (@hop_task.hop.free? || @hop_task.hop.assigned?(@current_user))
      hop_task_data = {}
      hop_task_data[:user_id] = @current_user.id
      hop_task_data[:hop_task_id] = params[:hop_task_id]
      hop_task_data[:photo] = params[:photo]
      hop_task_data[:comment] = params[:comment]
      @task = UserHopTask.new(hop_task_data)
      if @task.save
        if(@hop_task.hop.free? && !@hop_task.hop.assigned?(@current_user))
          @hop_task.hop.assign @current_user
        end

        @hop_task.hop.increase_score @current_user, @hop_task.pts
        render :json => {success: true,
                         info: "Task create!",
                         status: 200
        }
      else
        bad_request(@task.errors.to_json, 406)
      end
    else
      bad_request(['Can\'t find hop by id.'], 406)
    end
  end

  def friends_hop_tasks
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.find_by_sql("
      SELECT * FROM user_hop_tasks
      WHERE user_hop_tasks.user_id IN (SELECT friendships.friend_id
                                       FROM friendships
                                       WHERE friendships.user_id = #{@current_user.id} AND friendships.status = 'accepted')
      ORDER BY user_hop_tasks.created_at DESC
      LIMIT #{params[:per_page].to_i}
      OFFSET #{(params[:page].to_i - 1) * params[:per_page].to_i}
    ")
    render 'friends_hop_tasks', content_type: 'application/json'
  end

  def all_hoppers_hop_tasks
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.paginate(page: params[:page],
                                  per_page: params[:per_page],
                                  order: 'created_at DESC')
    render 'all_hoppers_hop_tasks', content_type: 'application/json'
  end

  def get_hop_task_by_id
    render 'get_hop_task_by_id', content_type: 'application/json'
  end

  def like
    unless Like.where(target_object_id: @user_hop_task.id, target_object: 'UserHopTask', user_id: @current_user.id).first
      if @user_hop_task.hop_task.hop
        @like = Like.create(target_object_id: @user_hop_task.id, target_object: 'UserHopTask', user_id: @current_user.id)
        Notification.create(user_id: @user_hop_task.user_id, like_id: @like.id, event_type: 'Like')
        @user_hop_task.hop_task.hop.increase_score @current_user, 1
        respond_to do |format|
          format.json{
            render :json => {success: true,
                             info: "Like Successfully!",
                             likes_count: Like.where(target_object_id: @user_hop_task.id, target_object: 'UserHopTask', user_id: @current_user.id).count ,
                             user_hop_task_id: @user_hop_task.id,
                             status: 200
            }
          }
        end
      else
        bad_request(['Task without hop.'], 406)
      end
    else
      bad_request(['Already liked.'], 406)
    end
  end

  def likes_count
    respond_to do |format|
      format.json{
        render :json => {likes_count: Like.where(target_object_id: @user_hop_task.id, target_object: 'UserHopTask', user_id: @current_user.id).count ,
                         user_hop_task_id: @user_hop_task.id
        }
      }
    end
  end

  def comment
    comment = @user_hop_task.comments.build(user_id: @current_user.id, text: params[:text])
    if comment.save
      Notification.create(user_id: @user_hop_task.user_id, comment_id: comment.id, event_type: 'Comment')
      respond_to do |format|
        format.json{
          render :json => {success: true,
                           info: "Comment create!",
                           status: 200
          }
        }
      end
    else
      bad_request(comment.errors.to_json, 406)
    end

  end

  def comments
    @comments = @user_hop_task.comments
    if @comments.blank?
      bad_request(['User hop task has no comments.'], 406)
    else
      render 'comments', content_type: 'application/json'
    end
  end

  def notify_by_share
    user_hop_task = UserHopTask.where(hop_task_id: @hop_task.id, user_id: @current_user.id).first
    if user_hop_task
      shared = user_hop_task.shared ? true : false
      if !shared
        user_hop_task.update_attribute :shared, true
        user_hop_task.hop_task.hop.increase_score @current_user, user_hop_task.hop_task.bonus
        respond_to do |format|
          format.json{
            render :json => {success: true,
                             info: 'Success.',
                             status: 200
            }
          }
        end
      else
        bad_request(['Already shared.'], 406)
      end
    else
      bad_request(['Cant find feed by.'], 406)
    end
  end

  def get_user_hop_task_by_id
    render 'get_user_hop_task_by_id', content_type: 'application/json'
  end

  private

  def load_hop_task
    @hop_task = HopTask.where(:id => params[:hop_task_id]).first
    bad_request(['Hop task not found.'], 406) unless @hop_task
  end

  def load_user_hop_task
    @user_hop_task = UserHopTask.where(:id => params[:user_hop_task_id]).first
    bad_request(['User hop task not found.'], 406) unless @user_hop_task
  end

end