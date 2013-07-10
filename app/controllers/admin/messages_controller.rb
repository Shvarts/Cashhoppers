class Admin::MessagesController < ApplicationController
  layout "application", except: [:wice_grid]
  def email_tool
    puts"-------------------------------#{flash[:text]}--------------------------------"
    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name')

 end
  @var=12
  def wice_grid
     puts"-----------------------------------------------------------------"
    @hops_grid= initialize_grid(Hop, per_page: 5, :order => 'hops.name',
      :include => [:hop]
    )
    render :partial => 'wice_grid'

  end

  def message_tool

  end

  def close_grid
    if params[:close].to_i==0
      session.delete('close')
    else
     session[:close]=params["close"]
    end
    redirect_to 'email_tool'
  end

  def text_tool

  end
end
