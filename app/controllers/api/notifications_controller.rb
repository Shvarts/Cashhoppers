class Api::NotificationsController < Api::ApplicationController
  def get_events_list
    @events = Notification.paginate(conditions: {user_id: @current_user.id},
                                   page:       params[:page],
                                   per_page:   params[:per_page],
                                   order:      'created_at DESC')
    render 'get_events_list', content_type: 'application/json'
  end
end
