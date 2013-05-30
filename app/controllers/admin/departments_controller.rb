# encoding: utf-8 rails

class Admin::DepartmentsController < Admin::ApplicationController
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to admin_departments_path, alert: "There is no Department with ID=#{params[:id]}."
  end

  def index
    @departments = @departments.order(sort_order).page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @department.save
      redirect_to [:admin, @department], notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def update
    if @department.update_attributes(params[:department])
      redirect_to [:admin, @department], notice: 'Successfully updated Department.'
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to admin_departments_url, notice: 'Successfully destroyed Department.'
  end
end
