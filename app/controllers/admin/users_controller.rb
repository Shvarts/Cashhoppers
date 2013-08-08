class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users_grid = initialize_grid(User,  per_page: 20)
  end

  def change_user_role
    user = User.find(params[:user_id])
    role = Role.find(params[:new_role_id])
    if user && role
      user.roles = [role]
      render :text => "Succesfully changed "+user.email + " role to " + role.name
    else
      render :text => "error"
    end


  end
end
