class Admin::SelectedCatalogsController < Admin::ApplicationController
  authorize_resource class: Catalog

  def index
    @catalogs = Catalog.selected_catalogs_ar('ENG').includes(:parent)
    @books = Catalog.where(books_catalog: true).first
  end

  def new
    @catalog = Catalog.new
  end

  def edit
    @catalog = Catalog.find(params[:id])
  end

  def update
    @catalog = Catalog.find(params[:id])
    authorize! :update, @catalog

    if @catalog.update_attribute(:selected_catalog, params[:catalog][:selected_catalog])
      redirect_to admin_selected_catalogs_url, :notice => "Successfully updated catalog."
    else
      render :edit
    end
  end

  def new_books
    @catalog = Catalog.new
  end

  def set_books
    name = params[:catalog][:name]
    catalog = Catalog.where(name: name).first
    books_catalogs = Catalog.where(books_catalog: true)
    if catalog && books_catalogs.each{|catalog| catalog.update_attribute(:books_catalog, false)} && catalog.update_attribute(:books_catalog, true)
      redirect_to admin_selected_catalogs_url, :notice => "Successfully selected Books Root Catalog."
    else
      @catalog = Catalog.new({name: name})
      @catalog.errors.add(:name, "Catalog \"#{name}\" does not exist.")
      render :new_books
    end
  end

  def unset_books
    Catalog.find(params[:id]).update_attribute(:books_catalog, false)
    redirect_to :action => 'index', :notice => "Successfully unselected Books Root Catalog."
  end

  def set_selected
    name = params[:catalog][:name]
    catalog = Catalog.where(name: name).first
    if catalog && catalog.update_attribute(:selected_catalog, params[:catalog][:selected_catalog])
      redirect_to admin_selected_catalogs_url, :notice => "Successfully selected catalog."
    else
      @catalog = Catalog.new({name: name})
      @catalog.errors.add(:name, "Catalog \"#{name}\" does not exist.")
      render :new
    end
  end

  def unset_selected
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attribute(:selected_catalog, 0)
      redirect_to :action => 'index', :notice => "Successfully unselected catalog."
    else
      render :index, notice: "Unable to unselect catalog #{@catalog.name}"
    end
  end

  def autocomplete
    catalogs = Catalog.order(:name).where('name like ?', "#{params[:term]}%").pluck(:name)
    render json: catalogs
  end
end
