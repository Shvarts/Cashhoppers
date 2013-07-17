class Admin::AdminController < ApplicationController

  before_filter :authenticate_user!

  def sidebar
    'admin/admin_sidebar'
  end

end
