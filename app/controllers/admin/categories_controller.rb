class Admin::CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.page(params[:page])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
    @category.suid = "Initial system name"
    Language.all.each do |language|
      @category.category_descriptions.build(lang: language.code3)
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])
    authorize! :create, @category

    if @category.save
      redirect_to admin_category_path(@category), notice: 'Successfully created admin/category.'
    else
      render action: 'new'
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])
    authorize! :update, @category

    if @category.update_attributes(params[:category])
      redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, @category
    @category.destroy
    redirect_to admin_categories_url, notice: 'Successfully destroyed admin/category.'
  end
end
