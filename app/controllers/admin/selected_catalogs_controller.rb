class Admin::SelectedCatalogsController < Admin::ApplicationController
  authorize_resource class: Catalog

  def index
    @catalogs = Catalog.selected_catalogs
  end

  def new
    @catalog = Catalog.new
  end

  def set_selected
    name = params[:catalog][:catalognodename]
    catalog = Catalog.where(catalognodename: name).first
    if catalog && catalog.update_attribute(:selected_catalog, true)
      redirect_to admin_selected_catalogs_url, :notice => "Successfully selected catalog."
    else
      @catalog = Catalog.new({catalognodename: name})
      @catalog.errors.add(:catalognodename, "Catalog \"#{name}\" does not exist.")
      render :action => 'new'
    end
  end

  def unset_selected
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attribute(:selected_catalog, :false)
      redirect_to :action => 'index', :notice => "Successfully unselected catalog."
    else
      render :action => 'index', notice: "Unable to unselect catalog #{@catalog.catalognodename}"
    end
  end

  def autocomplete
    catalogs = Catalog.order(:catalognodename).where('catalognodename like ?', "#{params[:term]}%").pluck(:catalognodename)
    render json: catalogs
  end
end
