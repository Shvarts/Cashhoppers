class Admin::SearchController < Admin::AdminController
  def current_hops
	@tasks_grid = initialize_grid(Hop)#.where(:close => false))
  end

  def hops_archive
	@tasks_grid = initialize_grid(Hop)#.where(:close => true))
  end
end
