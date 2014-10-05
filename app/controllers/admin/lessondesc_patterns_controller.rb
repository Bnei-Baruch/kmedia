class Admin::ContainerDescriptionPatternsController < Admin::ApplicationController
  before_filter :common_set, :only => [:new, :create, :edit, :update]
  load_and_authorize_resource

  def index
    @container_desc_patterns = @container_desc_patterns.order(sort_order).includes([:catalogs]).page(params[:page]).per(50)
  end

  def show
  end

  def new
  end

  def create
    @container_desc_pattern.user = current_user
    if @container_desc_pattern.save
      redirect_to [:admin, @container_desc_pattern], :notice => "Successfully created Container Description pattern."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @container_desc_pattern.update_attributes(params[:container_desc_pattern]) &&
        @container_desc_pattern.update_attribute(:user_id, current_user.id)
      redirect_to [:admin, @container_desc_pattern], :notice => "Successfully updated Container Description pattern."
    else
      render :edit
    end
  end

  def destroy
    @container_desc_pattern.destroy
    redirect_to admin_container_desc_patterns_url, :notice => "Successfully destroyed Container Description pattern."
  end

  private

  def common_set
    @languages = Language::ALL_LANGUAGES
  end

  def default_sort_column
    'pattern'
  end
end
