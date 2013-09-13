class Api::PaymentController < Api::ApplicationController

  def get_frog_legs_count
    @user = User.find(@current_user.id)
    unless @user.frog_legs
      @user.update_attribute :frog_legs, 0
    end
    render :json => {
      frog_legs_count: @user.frog_legs
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
    user = User.find(@current_user.id)
    unless user.user_settings
      user.user_settings = UserSettings.create
    end
    if user.frog_legs == nil
      user.update_attribute :frog_legs, 0
    end

    if !user.user_settings.ad_enable
      bad_request ['Already disabled ads.'], 406
    elsif user.frog_legs < 20
      bad_request ['You dont have enough many.'], 406
    else
      user.user_settings.update_attribute :ad_enable, 0
      user.update_attribute :frog_legs, user.frog_legs - 20 #need refactor
      message = 'Succesfully disabled ads.'
      render :json => {
        message: message
      }
    end
  end

  def buy_hop
    user = User.find(@current_user.id)

    unless user.user_settings
      user.user_settings = UserSettings.create
    end

    @hop = Hop.where(id: params[:hop_id]).first

    if @hop
      if @hop.assigned?(user)
        bad_request ['Already paid hop.'], 406
      elsif User.find(user.id).frog_legs < @hop.price
        bad_request ['You dont have enough many.'], 406
      else
        @hop.assign user
        user.update_attribute :frog_legs, (user.frog_legs - @hop.price)
        render :json => {
          message: 'Succesfully paid hop.'
        }
      end
    else
      bad_request ['Can\'t find hop by id.'], 406
    end
  end


end
