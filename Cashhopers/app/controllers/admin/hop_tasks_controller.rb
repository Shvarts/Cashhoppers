class Admin::HopTasksController < ApplicationController
  # GET hops/1/hop_tasks
  # GET hops/1/hop_tasks.json
  before_filter :authenticate_user!

  def index
    @hop = Hop.find(params[:hop_id])
    @hop_tasks = @hop.hop_tasks

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @hop_tasks }
    end
  end

  # GET hops/1/hop_tasks/1
  # GET hops/1/hop_tasks/1.json
  def show

    @hop_task = HopTask.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hop_task }
    end
  end

  # GET hops/1/hop_tasks/new
  # GET hops/1/hop_tasks/new.json
  def new

    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.build

    respond_to do |format|
      format.html # new.html.haml
      format.json { render :json => @hop_task }
    end
  end

  # GET hops/1/hop_tasks/1/edit
  def edit
    @hop_task=HopTask.find(params[:id])
    @hop=@hop_task.hop

    #@hop = Hop.find(params[:hop_id])
 #   @hop_task = @hop.hop_tasks.find(params[:id])
  end

  # POST hops/1/hop_tasks
  # POST hops/1/hop_tasks.json
  def create
#    params[:hop_task][:sponsor_id]=current_user.id
    @hop=Hop.find(params["hop_id"])
    @hop_task = HopTask.new(:sponsor_id=>current_user.id, :text_for_hop=>params["text_for_hop"],
                             :hop_task_price=>params["hop_task_price"],
                            # :hop_picture =>params["hop_picture"],
                             :hop_id => params["hop_id"]
    )
    if @hop_task.save


#    @hop = Hop.find(params[:hop_id])
#    @hop_task = @hop.hop_tasks.build(params[:hop_task])
#
   respond_to do |format|
#      if @hop_task.save
        format.html { redirect_to :back, :notice => 'Hop task was successfully created.' }
        format.json { render :json => @hop_task, :status => :created, :location => [@hop_task.hop, @hop_task] }
#      else
        format.html {  redirect_to :back }
        format.json { render :json => @hop_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT hops/1/hop_tasks/1
  # PUT hops/1/hop_tasks/1.json
  def update


    @hop_task = HopTask.find(params[:id])

    respond_to do |format|
      if @hop_task.update_attributes(params[:hop_task])
        format.html { redirect_to(admin_hop_path(@hop_task.hop), :notice => 'Hop task was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @hop_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE hops/1/hop_tasks/1
  # DELETE hops/1/hop_tasks/1.json
  def destroy

    @hop_task = HopTask.find(params[:id])
    @hop_task.destroy

    respond_to do |format|
      format.html { redirect_to admin_hop_path(@hop_task.hop)}
      format.json { head :ok }
    end
  end
end
