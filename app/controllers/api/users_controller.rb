class Api::UsersController < Api::ApplicationController
  respond_to :json

  before_filter :find_user, only: [:get_user_info]
  before_filter :filter_attributes, only: [:update_profile]

  def index
    params[:page] ||= 1
    params[:per_page] ||= 10
    conditions = []
    unless params[:query].blank?
      conditions = ["first_name LIKE ? OR last_name LIKE ? OR user_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"]
    end
    @users = User.paginate(page: params[:page], per_page: params[:per_page], conditions: conditions  )
    invalid_login_attempt('users not found') if @users.blank?

    render 'index', content_type: 'application/json'
  end

  def get_my_info
    @user = @current_user

    render 'get_my_info', content_type: 'application/json'
  end

  def get_user_info
    render 'get_user_info', content_type: 'application/json' unless @user
  end

  def update_profile
    if @current_user.update_attributes(@attributes)
      render :json => {success: true,
                       info: 'Profile successfully updated.',
                       status: 200
      }
    else
      bad_request @current_user.errors, 406
    end
  end

  private

  def find_user
    unless params[:user_id] && @user = User.where(params[:user_id]).first
      bad_request ['User not found.'], 406
    end
  end

  def filter_attributes
    @attributes = {}
    unless params[:first_name].blank?
      @attributes[:first_name] = params[:first_name]
    end
    unless params[:last_name].blank?
      @attributes[:last_name] = params[:last_name]
    end
    unless params[:user_name].blank?
      @attributes[:user_name] = params[:user_name]
    end
    unless params[:zip].blank?
      @attributes[:zip] = params[:zip]
    end
    unless params[:contact].blank?
      @attributes[:contact] = params[:contact]
    end
    unless params[:phone].blank?
      @attributes[:phone] = params[:phone]
    end
    unless params[:bio].blank?
      @attributes[:bio] = params[:bio]
    end
    unless params[:twitter].blank?
      @attributes[:twitter] = params[:twitter]
    end
    unless params[:facebook].blank?
      @attributes[:facebook] = params[:facebook]
    end
    unless params[:google].blank?
      @attributes[:google] = params[:google]
    end
    unless params[:password].blank?
      @attributes[:password] = params[:password]
      @attributes[:password_confirmation] = params[:password_confirmation]
    end
    unless params[:avatar].blank?
      @attributes[:avatar] = params[:avatar]
    end
  end

end
