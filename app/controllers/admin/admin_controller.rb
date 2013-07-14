class Admin::AdminController < ApplicationController

  before_filter :authenticate_user!

  def sub_layout
    'admin/admin_sub_layout'
  end

end
