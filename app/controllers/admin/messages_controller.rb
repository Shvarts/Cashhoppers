class Admin::MessagesController < ApplicationController
  layout "application", except: [:wice_grid]
  def email_tool

    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name')

 end
  @var=12
  def wice_grid


    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name')
    render :partial => 'wice_grid'

  end

  def message_tool

  end

  def text_tool

  end
end
