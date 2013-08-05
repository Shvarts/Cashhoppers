class Api::UserHopTasksController < Api::ApplicationController
  respond_to :json
  before_filter :load_hop_task, only: [:create, :get_hop_task_by_id]
  before_filter :load_user_hop_task, only: [:like, :likes_count, :comment, :comments, :notify_by_share, :get_user_hop_task_by_id]

  def create
    if UserHopTask.where(user_id: @current_user.id, hop_task_id: @hop_task.id).first
      bad_request(['Hop task already comleted.'], 406)
    elsif @hop_task && @hop_task.hop
      hop_task_data = {}
      hop_task_data[:user_id] = @current_user.id
      hop_task_data[:hop_task_id] = params[:hop_task_id]
      hop_task_data[:photo] = params[:photo]
      hop_task_data[:comment] = params[:comment]
      @task = UserHopTask.new(hop_task_data)
      if @task.save
        @hop_task.hop.assign @current_user
        @hop_task.hop.increase_score @current_user, @hop_task.pts
        render :json => {success: true,
                         info: "Task create!",
                         status: 200
        }
      else
        bad_request(@task.errors.to_json, 406)
      end
    end
  end

  def friends_hop_tasks
    params[:page] ||= 1
    params[:per_page] ||= 10
    @tasks = UserHopTask.find_by_sql("SELECT * FROM user_hop_tasks WHERE user_hop_tasks.user_id IN (SELECT friendships.friend_id FROM friendships
                                      WHERE friendships.user_id = #{@current_user.id}) LIMIT #{params[:per_page].to_i} OFFSET #{(params[:page].to_i - 1) * params[:per_page].to_i}")
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
      @like = Like.create(target_object_id: @user_hop_task.id, target_object: 'UserHopTask', user_id: @current_user.id)
      Notification.create(user_id: @user_hop_task.user_id, like_id: @like.id, event_type: 'Like')
      unless @user_hop_task.hop
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
    shared = false
    case params[:service]
    when 'facebook'
      shared = true if @user_hop_task.facebook_shared
      @user_hop_task.update_attribute :facebook_shared, true
    when 'twitter'
      shared = true if @user_hop_task.twitter_shared
      @user_hop_task.update_attribute :twitter_shared, true
    when 'google'
      shared = true if @user_hop_task.google_shared
      @user_hop_task.update_attribute :google_shared, true
    end
    if !shared
      @user_hop_task.hop_task.hop.increase_score @current_user, @user_hop_task.hop_task.bonus
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