class Admin::CatalogsController < Admin::ApplicationController
  include TheSortableTreeController::Rebuild

  load_resource :only => [:show, :new, :destroy, :edit, :update, :create]
  authorize_resource

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to admin_lessons_path, :alert => "There is no Container with ID=#{params[:id]}."
  end

  def index
    @catalogs = Catalog.accessible_by(current_ability, :index).order(sort_order).includes(:parent)
    if params[:q]
      # request for catalogs from ui token input box
      @catalogs = @catalogs.open_matching_string(params[:q]).
          multipluck(:'catalognode.catalognodeid', :'catalognode.catalognodename as name').
          map { |cat| {id: cat['catalognodeid'], name: cat['name']} }
    else
      @catalogs = @catalogs.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.json { render :json => @catalogs }
    end
  end

  def show
    @lessons = @catalog.lessons.includes([:content_type, :language,])
  end

  def new
    Language.order('code3').all.each { |l|
      @catalog.catalog_descriptions.build(:lang => l.code3)
    }
    @catalog_descriptions = sort_descriptions(@catalog)
  end

  def create
    @catalog.user = current_user
    if @catalog.save
      redirect_to [:admin, @catalog], :notice => "Successfully created catalog."
    else
      render :new
    end
  end

  def edit
    # existing_languages - all_languages
    (Language.order('code3').pluck(:code3) - @catalog.catalog_descriptions.pluck(:lang)).each { |code3|
      @catalog.catalog_descriptions.build(:lang => code3)
    }
    @catalog_descriptions = sort_descriptions(@catalog)
  end

  def update
    @catalog.attributes = params[:catalog]
    @catalog.user = current_user
    update_children_visibility if visibility_changed?
    if @catalog.save
      redirect_to admin_catalog_path(@catalog), :notice => "Successfully updated catalog."
    else
      render :edit
    end
  end

  def destroy
    @catalog.destroy
    redirect_to admin_catalogs_url, :notice => "Successfully destroyed catalog."
  end

  def batch
    container = Lesson.find(params[:lesson_id]) rescue nil
    render :json => {ok: false, msg: "Unable to find container #{params[:lesson_id]}"} and return unless container

    case
      when md = /security_(?<security_level>[0-4])/.match(params[:batch_type])
        container.update_attribute(:secure, md[:security_level])
      else
        render :json => {ok: false, msg: "Unknown request #{params[:batch_type]}"} and return
    end
    respond_to do |format|
      format.json { render :json => {ok: true} }
    end
  end

  def manage
    @catalogs = Catalog.order('catorder ASC').all
  end

  def move_prepare
    @target = Catalog.find(params[:id])
    @catalogs = Catalog.where(catalognodeid: params[:sources].split(',').map(&:to_i)).includes(:lessons)
  end

  def move
    target = Catalog.find(params[:id])
    source = Catalog.find(params[:from])
    containers = Lesson.where(lessonid: params[:containers].split(',').map(&:to_i))
    Catalog.move(target: target, source: source, containers: containers)

    redirect_to manage_admin_catalogs_path
  end

  private
  def sort_descriptions(catalog)
    catalog_descriptions_main = {}
    catalog_descriptions_all = []
    catalog.catalog_descriptions.each { |x|
      if MAIN_LANGS.include? x.lang
        catalog_descriptions_main[x.lang] = x
      else
        catalog_descriptions_all << x
      end
    }
    MAIN_LANGS.map { |l| catalog_descriptions_main[l] } + catalog_descriptions_all.sort_by { |x| x.lang }
  end

  def default_sort_column
    "catalognodename"
  end

  def default_sort_direction
    "asc"
  end

  def update_children_visibility
    # when catalog visibility changes update visibility to it children
    return if @catalog.children.empty?
    children = get_all_children(@catalog).flatten
    ids = children.collect(&:catalognodeid)
    Catalog.update_all({:visible => @catalog.visible}, ["catalognodeid IN (?)", ids]) unless ids.empty?
  end

  def visibility_changed?
    @catalog.changes.has_key? ("visible")
  end

  # We use recursion method to fetch all the children for catalog node => should be changed after moving to postgres
  # Gets all children(descendants) for the given catalog node
   def get_all_children(catalog)
    Catalog.descendant_catalogs(catalog)
  end


end
