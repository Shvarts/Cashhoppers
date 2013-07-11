class Admin::MessagesController < ApplicationController
  before_filter :authenticate_user!


  def email_tool

    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name')

 end
  @var=12
  def wice_grid

    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name',
      :include => [:hop]
    )
    render :partial => 'wice_grid'

  end

  def message_tool

  end

  def close_grid
    if params[:close].to_i==0
      session[:close]=0
      session.delete('close')
    else
     session[:close]=params["close"]
    end
    redirect_to 'email_tool'
  end

  def text_tool

  end
end
