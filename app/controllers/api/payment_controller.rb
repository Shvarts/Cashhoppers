class Api::PaymentController < Api::ApplicationController

  def get_frog_legs_count
    render :json => {
      frog_legs_count: @current_user.frog_legs
    }
  end

  def refill_your_account
    if params[:frog_legs_count].present? && params[:frog_legs_count].to_i > 0
      @current_user.update_attribute(:frog_legs, (@current_user.frog_legs + params[:frog_legs_count].to_i))
      render :json => {
        message: 'Successfully updated your balance.'
      }
    else
      bad_request ['Bad params.'], 406
    end
  end

  def disable_ads
    unless @current_user.user_settings
      @current_user.user_settings = UserSettings.create
    end

    if !@current_user.user_settings.ad_enable
      bad_request ['Already disabled ads.'], 406
    elsif @current_user.frog_legs < 20
      bad_request ['You dont have enough many.'], 406
    else
      @current_user.user_settings.update_attribute :ad_enable, 0
      @current_user.update_attribute :frog_legs, @current_user.frog_legs - 20 #need refactor
      message = 'Succesfully disabled ads.'
      render :json => {
        message: message
      }
    end
  end

end
