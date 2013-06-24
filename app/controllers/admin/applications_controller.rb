class Admin::ApplicationsController < ApplicationController
  load_and_authorize_resource
  # GET /admin/applications
  # GET /admin/applications.json
  def index
    @admin_applications = Application.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_applications }
    end
  end

  # GET /admin/applications/1
  # GET /admin/applications/1.json
  def show
    @admin_application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_application }
    end
  end

  # GET /admin/applications/new
  # GET /admin/applications/new.json
  def new
    @admin_application = Application.new
    range = [*'0'..'9', *'a'..'z', *'A'..'Z']
    @admin_application.api_key = Array.new(30){range.sample}.join

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_application }
    end
  end

  # GET /admin/applications/1/edit
  def edit
    @admin_application = Application.find(params[:id])
  end

  # POST /admin/applications
  # POST /admin/applications.json
  def create
    @admin_application = Application.new(params[:admin_application])

    respond_to do |format|
      if @admin_application.save
        format.html { redirect_to @admin_application, notice: 'Application was successfully created.' }
        format.json { render json: @admin_application, status: :created, location: @admin_application }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/applications/1
  # PUT /admin/applications/1.json
  def update
    @admin_application = Application.find(params[:id])

    respond_to do |format|
      if @admin_application.update_attributes(params[:admin_application])
        format.html { redirect_to @admin_application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/applications/1
  # DELETE /admin/applications/1.json
  def destroy
    @admin_application = Application.find(params[:id])
    @admin_application.destroy

    respond_to do |format|
      format.html { redirect_to admin_applications_url }
      format.json { head :no_content }
    end
  end
end
