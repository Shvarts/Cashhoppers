module ApplicationHelper

  def full_user_name user
    name = ''
    name += user.first_name + ' ' if user.first_name
    name += user.last_name if user.last_name
    name
  end

end
