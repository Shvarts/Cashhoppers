class Admin::AdminController < ApplicationController

  before_filter :authenticate_user!, :except => [:hop_photos]

  def sidebar
    'admin/admin_sidebar'
  end

end
