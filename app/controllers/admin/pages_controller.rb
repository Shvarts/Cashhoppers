class Admin::PagesController < Admin::AdminController
  def index
  end

  def hoppers_list
    @users_grid = initialize_grid(User, per_page:'9')
  end
end
