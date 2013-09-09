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
    if params[:user_settings]
      params[:user_settings].delete(:ad_enable)
      params[:user_settings].delete(:friend_invite)     if (params[:user_settings][:friend_invite].class != 'Boolean')    || (params[:user_settings][:friend_invite] == nil)
      params[:user_settings].delete(:message)           if (params[:user_settings][:message].class != 'Boolean')          || (params[:user_settings][:message] == nil)
      params[:user_settings].delete(:new_hop)           if (params[:user_settings][:new_hop].class != 'Boolean')          || (params[:user_settings][:new_hop] == nil)
      params[:user_settings].delete(:hop_about_to_end)  if (params[:user_settings][:hop_about_to_end].class != 'Boolean') || (params[:user_settings][:hop_about_to_end] == nil)
      params[:user_settings].delete(:comment_or_like)   if (params[:user_settings][:comment_or_like].class != 'Boolean')  || (params[:user_settings][:comment_or_like] == nil)
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

