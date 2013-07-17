class Admin::SearchController < Admin::AdminController
  def current_hops
    @tab = 'current_hops'
	  @tasks_grid = initialize_grid(Hop)#.where(:close => false))
  end

  def hops_archive
    @tab = 'archived_hops'
	  @tasks_grid = initialize_grid(Hop)#.where(:close => true))
  end

  def sub_layout
    'admin/hops_tabs'
  end

end
