class Api::SettingsController < Api::ApplicationController

  def get
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end
    settings = user.user_settings
    render json: {
      friend_invite:        settings.friend_invite,
      comment_or_like:      settings.comment_or_like,
      new_hop:              settings.new_hop,
      message:              settings.message,
      hop_about_to_end:     settings.hop_about_to_end
    }
  end

  def set
    user = User.where(id: @current_user.id).first
    unless user.user_settings
      user.user_settings = UserSettings.create()
    end
    params[:user_settings][:ad_enable] = nil
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

