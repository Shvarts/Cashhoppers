class Api::PaymentController < Api::ApplicationController

  def get_frog_legs_count
    render :json => {
      frog_legs_count: @current_user.frog_legs
    }
  end

end
