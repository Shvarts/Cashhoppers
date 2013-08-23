class Api::SettingsController < Api::ApplicationController

  def get
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end
    settings = user.user_settings
    render json: {
      friend_invite:        settings.friend_invite,
      friend_invite_accept: settings.friend_invite_accept,
      end_of_hop:           settings.end_of_hop,
      comment:              settings.comment,
      like:                 settings.like,
      ad_enable:            settings.ad_enable,
      message:              settings.message,
      new_hop:              settings.new_hop,
      hop_about_to_end:     settings.hop_about_to_end
    }
  end

  def set
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end
    params[:ad_enable] = nil
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
