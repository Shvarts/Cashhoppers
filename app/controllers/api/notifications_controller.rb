class Api::NotificationsController < Api::ApplicationController
  def get_events_list

    notifications = Notification.where(user_id: @current_user.id)
    notifications.each do |i|
      notifications.delete(i) if i.event_type = 'Friend invite' && i.friend.nil?
    end

    @events = notifications.paginate(
                                   page:       params[:page],
                                   per_page:   params[:per_page],
                                   order:      'created_at DESC')
    render 'get_events_list', content_type: 'application/json'
  end
end
