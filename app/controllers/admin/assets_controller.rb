class Admin::AssetsController < ApplicationController
  def index
    @assets = Asset.page(params[:page])
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:file])
    if @asset.save
      redirect_to [:admin, @asset], :notice => "Successfully created file."
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def update
    @asset = Asset.find(params[:id])
    if @asset.update_attributes(params[:file])
      redirect_to [:admin, @asset], :notice  => "Successfully updated file."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to admin_assets_url, :notice => "Successfully destroyed file."
  end
end
