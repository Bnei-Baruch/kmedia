class Admin::ContainersController < Admin::ApplicationController
  before_filter :set_fields, :only => [:new, :create, :edit, :update, :edit_long_descr, :update_long_descr, :edit_transcript, :update_transcript, :send_to_censor]

  def index
    authorize! :index, Container
    @filter = FilterDecorator.new(params[:filter])
    @security = params[:security]
    @containers = Container.get_appropriate_containers(@filter, @security).order(sort_order).page(params[:page])
  end

  def show
    begin
      @container = Container.find(params[:id])
      @censor_email = @container.censor_id ? User.where(id: @container.censor_id).pluck(:email)[0] : nil
      authorize! :show, @container
    rescue
      redirect_to admin_containers_path, :alert => "There is no Container with ID=#{params[:id]}."
      return
    end
    @secure = SECURITY.select { |s| s[:level] == @container.secure }.first[:name]
  end

  def new
    @container = Container.new
    authorize! :new, @container
    @container.catalogs << @rss # Add it to RSS by default
    @languages.each { |l|
      @container.container_descriptions.build(:lang => l.code3)
      @container.container_transcripts.build(:lang => l.code3)
    }
    @container_descriptions = sort_descriptions
    @container_transcripts = sort_transcripts
  end

  def create
    @container = Container.new
    authorize! :create, @container

    @container.attributes = params[:container]
    @container.user = current_user

    if @container.save
      redirect_to admin_container_path(@container), :notice => "Successfully created admin/container."
    else
      @container_descriptions = sort_descriptions
      @container_transcripts = sort_transcripts
      render :new
    end
  end

  def edit
    authorize_and_build_language_maps

    @containers = Container.where(:marked_for_merge => true)
  end

  def update
    @container = Container.find(params[:id])
    authorize! :update, @container

    @container.set_updated_attributes @current_user, params[:container]
    @container.user = current_user

    if @container.save
      redirect_to admin_container_path(@container), :notice => "Successfully updated admin/container."
    else
      @container_descriptions = sort_descriptions
      @container_transcripts = sort_transcripts
      @containers = Container.where(:marked_for_merge => true)
      render :edit
    end
  end

  def edit_long_descr
    authorize_and_build_language_maps
  end

  def edit_transcript
    authorize_and_build_language_maps
  end

  def update_transcript
    @container = Container.find(params[:id])
    authorize! :edit_descriptions, @container

    @container.attributes = params[:container]
    generate_transcript_table_of_content
    if @container.container_transcripts.each(&:save)
      redirect_to admin_container_path(@container), :notice => "Successfully updated container transcript."
    else
      @container_transcripts = sort_transcripts
      render :edit_transcript
    end
  end

  def update_long_descr
    @container = Container.find(params[:id])
    authorize! :edit_descriptions, @container
    @container.attributes = params[:container]
    if @container.container_descriptions.each(&:save)
      redirect_to admin_container_path(@container), :notice => "Successfully updated container long description."
    else
      @container_descriptions = sort_descriptions
      render :edit_long_descr
    end
  end

  def destroy
    @container = Container.find(params[:id])
    authorize! :destroy, @container
    @container.destroy
    redirect_to admin_containers_url, :notice => "Successfully destroyed admin/container."
  end

  def mark_for_merge
    begin
      container = Container.find(params[:id])
    rescue
      render :js => 'alert("No such container")'
      return
    end
    container.update_attribute(:marked_for_merge, !container.marked_for_merge)
    render :js => container.marked_for_merge ?
        "$('.mark_for_merge').addClass('btn-warning').text('Unmark')" :
        "$('.mark_for_merge').removeClass('btn-warning').text('Mark')"
  end

  def merge_get_list
    @container = Container.find(params[:id])
    render :nothing => true and return unless @container

    @containers = Container.where(:marked_for_merge => true)

    render :text => 'empty' and return if @containers.count == 0

    render :text => 'recursion' and return if @containers.map(&:id).include? @container.id # Recursion

    render :layout => false
  end

  def merge
    @container = Container.find(params[:id])
    merge_ids = params[:container][:container_ids].map(&:to_i)
    merges = Container.where(id: merge_ids).each { |merge|
      # copy files
      merge.file_assets.each { |fa|
        @container.file_assets << fa rescue nil
      }
      # empty files from merged container
      merge.file_assets = []
      # remove container
      merge.destroy
    }
    # clear all selections
    Container.where(:marked_for_merge => true).each { |container| container.update_attribute(:marked_for_merge, false) }
    render :show
  end

  def get_update
    @update = OpenStruct.new(container_name: params[:container_name], files: params[:files], dry_run: params[:dry_run])
  end

  def add_update
    Container.add_update(params[:container_name], [params[:files]], params[:dry_run])
    @update = OpenStruct.new(container_name: params[:container_name], files: params[:files], dry_run: params[:dry_run])
    render :get_update, alert: 'Executed'
  end

  # Combine containers to VL
  def combine
    permitted = can? :update, :container

    begin
      containers = if params[:container]
                     # Create new VL
                     [Container.find(params[:container])]
                   elsif params[:containers]
                     # Add containers to a new VL
                     params[:containers].split(',').map { |vl| Container.find vl }
                   else
                     raise
                   end

      film_date = containers[0].filmdate
      vl = VirtualContainer.create!(film_date: film_date)
      vl.containers = containers
    rescue Exception => e
      redirect_to admin_containers_path, alert: "Error: #{e.message}"
      return
    end

    redirect_to admin_containers_path, notice: "Container(s) #{params[:containers]} successfully moved to VL(#{vl.id}, #{vl.film_date})"
  end

  def send_to_censor
    container = Container.find(params[:id])
    container.update_attribute :for_censorship, true

    @filter = params[:filter]
    @security = params[:security]
    @containers = Container.get_appropriate_containers(@filter, @security).order(sort_order).page(params[:page])
    redirect_to request.referer, notice: 'Sent for Censorship'
  end

  private
  def set_fields
    @languages = Language::ALL_LANGUAGES
    @lecturers = Lecturer.all
    @content_types = ContentType.all.map { |ct| [ct.name, ct.id] }
    @security = SECURITY.collect { |s| [s[:name], s[:level]] }
    @rss = Catalog.find_by_name('Video')
  end

  def sort_descriptions
    container_descriptions_main = {}
    container_descriptions_all = []
    @container.container_descriptions.each { |x|
      if MAIN_LANGS.include? x.lang
        container_descriptions_main[x.lang] = x
      else
        container_descriptions_all << x
      end
    }
    MAIN_LANGS.map { |l| container_descriptions_main[l] } + container_descriptions_all.sort_by { |x| x.lang }
  end

  def sort_transcripts
    container_transcripts_main = {}
    container_transcripts_all = []
    @container.container_transcripts.each { |x|
      if MAIN_LANGS.include? x.lang
        container_transcripts_main[x.lang] = x
      else
        container_transcripts_all << x
      end
    }
    MAIN_LANGS.map { |l| container_transcripts_main[l] } + container_transcripts_all.sort_by { |x| x.lang }
  end

  def authorize_and_build_language_maps
    @container = Container.find(params[:id])
    authorize! :edit_descriptions, @container

    @container.build_descriptions_and_translations(@languages)
    @container_descriptions = sort_descriptions
    @container_transcripts = sort_transcripts
  end

  def generate_transcript_table_of_content
    @container.container_transcripts.each do |t|
      doc = Nokogiri::HTML.parse(t.transcript)
      toc = ''
      doc.xpath('//h1').each do |h_tag|
        toc = toc << '<br/>' if !toc.empty?
        toc = toc + h_tag.content
      end
      t.toc = toc
    end
  end

  def get_catalogs_from_matched_description_patterns
    @descriptions.select do |d|
      !d.catalogs.empty?
    end.try(:catalogs)
  end

  def default_sort_column
    'created_at'
  end

  def sort_order
    sort_line = sort_column + ' ' + sort_direction
    #secondary sort parameter
    sort_line += ', name asc' unless params[:sort].equal?('name')
  end
end
