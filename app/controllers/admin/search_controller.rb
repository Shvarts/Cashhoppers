class Admin::SearchController < Admin::AdminController
  def current_hops
	@tasks_grid = initialize_grid(Hop)
  end

  def hops_archive

  end
end
