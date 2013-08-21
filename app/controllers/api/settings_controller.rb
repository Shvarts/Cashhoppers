class Api::SettingsController < Api::ApplicationController

  def get
    unless @current_user.user_settings
      @current_user.user_settings = UserSettings.create()
    end
    settings = @current_user.user_settings
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
    unless @current_user.user_settings
      @current_user.user_settings = UserSettings.create()
    end

    if @current_user.user_settings.update_attributes params[:user_settings]
      render :json => {:success=>true,
                       :info => 'Settings succesfully updated.',
                       :status => 200
      }
    else
      bad_request ['error'], 406
    end

  end

end
