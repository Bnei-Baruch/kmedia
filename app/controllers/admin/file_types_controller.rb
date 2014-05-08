class Admin::FileTypesController < Admin::ApplicationController
  load_and_authorize_resource except: [:index]
  authorize_resource only: [:index]

  def index
    @file_types = FileType.page(params[:page]).per(50)
  end

  def show
  end

  def new
  end

  def create
    if @file_type.save
      redirect_to [:admin, @file_type], notice: 'Successfully created File Type.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    data = params[:file_type].except(:typename)
    if @file_type.update_attributes(data)
      redirect_to [:admin, @file_type], notice: 'Successfully updated File Type.'
    else
      render :edit
    end
  end

  def destroy
    @file_type.destroy
    redirect_to admin_file_types_url, notice: 'Successfully destroyed File Type.'
  end
end
