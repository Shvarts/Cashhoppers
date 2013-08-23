class Api::SettingsController < Api::ApplicationController

  def get
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end
    settings = user.user_settings
    render json: {
      friend_invite: settings.friend_invite,
      friend_invite_accept: settings.friend_invite_accept,
      end_of_hop: settings.end_of_hop,
      comment: settings.comment,
      like: settings.like,
      ad_enable: settings.ad_enable
    }
  end

  def set
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end

    if user.user_settings.update_attributes params[:user_settings]
      render :json => {:success=>true,
                       :info => 'Settings succesfully updated.',
                       :status => 200
      }
    else
      bad_request ['error'], 406
    end

  end

end
