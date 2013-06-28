class HopTasksController < ApplicationController
  # GET hops/1/hop_tasks
  # GET hops/1/hop_tasks.json
  def index
    @hop = Hop.find(params[:hop_id])
    @hop_tasks = @hop.hop_tasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hop_tasks }
    end
  end

  # GET hops/1/hop_tasks/1
  # GET hops/1/hop_tasks/1.json
  def show

    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.find(params[:id])

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
      format.html # new.html.erb
      format.json { render :json => @hop_task }
    end
  end

  # GET hops/1/hop_tasks/1/edit
  def edit
    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.find(params[:id])
  end

  # POST hops/1/hop_tasks
  # POST hops/1/hop_tasks.json
  def create
    params[:hop_task][:sponsor_id]=current_user.id

    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.build(params[:hop_task])

    respond_to do |format|
      if @hop_task.save
        format.html { redirect_to([@hop_task.hop, @hop_task], :notice => 'Hop task was successfully created.') }
        format.json { render :json => @hop_task, :status => :created, :location => [@hop_task.hop, @hop_task] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @hop_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT hops/1/hop_tasks/1
  # PUT hops/1/hop_tasks/1.json
  def update
    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.find(params[:id])

    respond_to do |format|
      if @hop_task.update_attributes(params[:hop_task])
        format.html { redirect_to([@hop_task.hop, @hop_task], :notice => 'Hop task was successfully updated.') }
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
    @hop = Hop.find(params[:hop_id])
    @hop_task = @hop.hop_tasks.find(params[:id])
    @hop_task.destroy

    respond_to do |format|
      format.html { redirect_to hop_hop_tasks_url(@hop) }
      format.json { head :ok }
    end
  end
end
