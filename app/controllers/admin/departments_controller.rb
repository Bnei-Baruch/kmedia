# encoding: utf-8 rails

class Admin::DepartmentsController < Admin::ApplicationController
  load_and_authorize_resource :only => [:show, :new, :destroy, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to admin_departments_path, :alert => "There is no Department with ID=#{params[:id]}."
  end

  def index
    @departments = Department.order(:name).page(params[:page])
  end


  def show
  end


  def new
   # @department = Department.new
  end


  def edit
    @department = Department.find(params[:id])
  end


  def create
    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        format.html { redirect_to [:admin, @department], notice: 'Department was successfully created.' }
        format.json { render json: @department, status: :created, location: @department }
      else
        format.html { render action: "new" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to [:admin, @department], notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to admin_departments_url }
      format.json { head :no_content }
    end
  end
end
