class DailyHopsController < ApplicationController
  # GET /daily_hops
  before_filter :authenticate_user!

  def index
    @daily_hops = DailyHop.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @daily_hops }
    end
  end

  # GET /daily_hops/1
  # GET /daily_hops/1.json
  def show
    @daily_hop = DailyHop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @daily_hop }
    end
  end

  # GET /daily_hops/new
  # GET /daily_hops/new.json
  def new
    @daily_hop = DailyHop.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @daily_hop }
    end
  end

  # GET /daily_hops/1/edit
  def edit
    @daily_hop = DailyHop.find(params[:id])
  end

  # POST /daily_hops
  # POST /daily_hops.json
  def create
    params[:daily_hop][:user_id]=current_user.id

    @daily_hop = DailyHop.new(params[:daily_hop])

    respond_to do |format|
      if @daily_hop.save
        format.html { redirect_to @daily_hop, notice: 'Daily hop was successfully created.' }
        format.json { render json: @daily_hop, status: :created, location: @daily_hop }
      else
        format.html { render action: "new" }
        format.json { render json: @daily_hop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /daily_hops/1
  # PUT /daily_hops/1.json
  def update
    @daily_hop = DailyHop.find(params[:id])

    respond_to do |format|
      if @daily_hop.update_attributes(params[:daily_hop])
        format.html { redirect_to @daily_hop, notice: 'Daily hop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @daily_hop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_hops/1
  # DELETE /daily_hops/1.json
  def destroy
    @daily_hop = DailyHop.find(params[:id])
    @daily_hop.destroy

    respond_to do |format|
      format.html { redirect_to daily_hops_url }
      format.json { head :no_content }
    end
  end
end
