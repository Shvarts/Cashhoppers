class Api::NotificationsController < Api::ApplicationController
  def get_events_list
    @events = Event.paginate(conditions: {user_id: @current_user.id},
                                   page:       params[:page],
                                   per_page:   params[:per_page],
                                   order:      'created_at DESC')

    respond_to do |format|
      format.json{}
    end
  end
end
