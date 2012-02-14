class Admin::FileAssetsController < Admin::ApplicationController
  def index
    @file_assets = FileAsset.page(params[:page])
  end

  def show
    @file_asset = FileAsset.find(params[:id])
  end

  def new
    @file_asset = FileAsset.new
  end

  def create
    @file_asset = FileAsset.new(params[:file])
    if @file_asset.save
      redirect_to [:admin, @files], :notice => "Successfully created file."
    else
      render :action => 'new'
    end
  end

  def edit
    @file_asset = FileAsset.find(params[:id])
  end

  def update
    @file_asset = FileAsset.find(params[:id])
    if @file_asset.update_attributes(params[:file])
      redirect_to [:admin, @files], :notice  => "Successfully updated file."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @file_asset = FileAsset.find(params[:id])
    @file_asset.destroy
    redirect_to admin_filess_url, :notice => "Successfully destroyed file."
  end
end
