class Admin::CatalogsController < ApplicationController
  def index
    @catalogs = Catalog.where("catalognodename like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @catalogs.map{|c| {:id => c.catalognodeid, :name => c.catalognodename} } }
    end
  end

  def show
    @catalog = Catalog.find(params[:id])
  end

  def new
    @catalog = Catalog.new
  end

  def create
    @catalog = Catalog.new(params[:catalog])
    if @catalog.save
      redirect_to [:admin, @catalog], :notice => "Successfully created catalog."
    else
      render :action => 'new'
    end
  end

  def edit
    @catalog = Catalog.find(params[:id])
  end

  def update
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attributes(params[:catalog])
      redirect_to [:admin, @catalog], :notice  => "Successfully updated catalog."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
    redirect_to admin_catalogs_url, :notice => "Successfully destroyed catalog."
  end
end
