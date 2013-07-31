module ApplicationHelper

  def current_user_name
    name = ''
    name += current_user.first_name + ' ' if current_user.first_name
    name += current_user.last_name if current_user.last_name
    name
  end

end
