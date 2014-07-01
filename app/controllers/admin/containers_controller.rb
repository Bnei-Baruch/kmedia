class Admin::LessonsController < Admin::ApplicationController
  before_filter :set_fields, :only => [:new, :create, :edit, :update, :edit_long_descr, :update_long_descr, :edit_transcript, :update_transcript, :send_to_censor]

  def index
    authorize! :index, Lesson
    @filter = params[:filter]
    @security = params[:security]
    @lessons = Lesson.get_appropriate_lessons(@filter, @security).order(sort_order).page(params[:page])
  end

  def show
    begin
      @lesson = Lesson.find(params[:id])
      @censor_email = @lesson.censor_id ? User.where(id: @lesson.censor_id).pluck(:email)[0] : nil
      authorize! :show, @lesson
    rescue
      redirect_to admin_lessons_path, :alert => "There is no Container with ID=#{params[:id]}."
      return
    end
    @secure = SECURITY.select { |s| s[:level] == @lesson.secure }.first[:name]
  end

  def new
    @lesson = Lesson.new
    authorize! :new, @lesson
    @lesson.catalogs << @rss # Add it to RSS by default
    @languages.each { |l|
      @lesson.lesson_descriptions.build(:lang => l.code3)
      @lesson.lesson_transcripts.build(:lang => l.code3)
    }
    @lesson_descriptions = sort_descriptions
    @lesson_transcripts = sort_transcripts
  end

  def create
    @lesson = Lesson.new
    authorize! :create, @lesson

    @lesson.attributes = params[:lesson]
    @lesson.user = current_user

    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully created admin/container."
    else
      @lesson_descriptions = sort_descriptions
      @lesson_transcripts = sort_transcripts
      render :new
    end
  end

  def edit
    authorize_and_build_language_maps

    @lessons = Lesson.where(:marked_for_merge => true)
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson

    @lesson.set_updated_attributes @current_user, params[:lesson]
    @lesson.user = current_user

    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated admin/container."
    else
      @lesson_descriptions = sort_descriptions
      @lesson_transcripts = sort_transcripts
      @lessons = Lesson.where(:marked_for_merge => true)
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
    @lesson = Lesson.find(params[:id])
    authorize! :edit_descriptions, @lesson

    @lesson.attributes = params[:lesson]
    generate_transcript_table_of_content
    if @lesson.lesson_transcripts.each(&:save)
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated container transcript."
    else
      @lesson_transcripts = sort_transcripts
      render :edit_transcript
    end
  end

  def update_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :edit_descriptions, @lesson
    @lesson.attributes = params[:lesson]
    if @lesson.lesson_descriptions.each(&:save)
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated container long description."
    else
      @lesson_descriptions = sort_descriptions
      render :edit_long_descr
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    authorize! :destroy, @lesson
    @lesson.destroy
    redirect_to admin_lessons_url, :notice => "Successfully destroyed admin/container."
  end

  def mark_for_merge
    begin
      lesson = Lesson.find(params[:id])
    rescue
      render :js => 'alert("No such container")'
      return
    end
    lesson.update_attribute(:marked_for_merge, !lesson.marked_for_merge)
    render :js => lesson.marked_for_merge ?
        "$('.mark_for_merge').addClass('btn-warning').text('Unmark')" :
        "$('.mark_for_merge').removeClass('btn-warning').text('Mark')"
  end

  def merge_get_list
    @lesson = Lesson.find(params[:id])
    render :nothing => true and return unless @lesson

    @lessons = Lesson.where(:marked_for_merge => true)

    render :text => 'empty' and return if @lessons.count == 0

    render :text => 'recursion' and return if @lessons.map(&:id).include? @lesson.id # Recursion

    render :layout => false
  end

  def merge
    @lesson = Lesson.find(params[:id])
    merge_ids = params[:lesson][:container_ids].map(&:to_i)
    merges = Lesson.where(id: merge_ids).each { |merge|
      # copy files
      merge.file_assets.each { |fa|
        @lesson.file_assets << fa rescue nil
      }
      # empty files from merged container
      merge.file_assets = []
      # remove container
      merge.destroy
    }
    # clear all selections
    Lesson.where(:marked_for_merge => true).each { |lesson| lesson.update_attribute(:marked_for_merge, false) }
    render :show
  end

  def get_update
    @update = OpenStruct.new(container_name: params[:container_name], files: params[:files], dry_run: params[:dry_run])
  end

  def add_update
    Lesson.add_update(params[:container_name], [params[:files]], params[:dry_run])
    @update = OpenStruct.new(container_name: params[:container_name], files: params[:files], dry_run: params[:dry_run])
    render :get_update, alert: 'Executed'
  end

  # Combine containers to VL
  def combine
    permitted = can? :update, :lesson

    begin
      containers = if params[:container]
                     # Create new VL
                     [Lesson.find(params[:container])]
                   elsif params[:containers]
                     # Add containers to a new VL
                     params[:containers].split(',').map { |vl| Lesson.find vl }
                   else
                     raise
                   end

      film_date = containers[0].filmdate
      vl = VirtualLesson.create!(film_date: film_date)
      vl.lessons = containers
    rescue Exception => e
      redirect_to admin_lessons_path, alert: "Error: #{e.message}"
      return
    end

    redirect_to admin_lessons_path, notice: "Container(s) #{params[:containers]} successfully moved to VL(#{vl.id}, #{vl.film_date})"
  end

  def send_to_censor
    lesson = Lesson.find(params[:id])
    lesson.update_attribute :for_censorship, true

    @filter = params[:filter]
    @security = params[:security]
    @lessons = Lesson.get_appropriate_lessons(@filter, @security).order(sort_order).page(params[:page])
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
    lesson_descriptions_main = {}
    lesson_descriptions_all = []
    @lesson.lesson_descriptions.each { |x|
      if MAIN_LANGS.include? x.lang
        lesson_descriptions_main[x.lang] = x
      else
        lesson_descriptions_all << x
      end
    }
    MAIN_LANGS.map { |l| lesson_descriptions_main[l] } + lesson_descriptions_all.sort_by { |x| x.lang }
  end

  def sort_transcripts
    lesson_transcripts_main = {}
    lesson_transcripts_all = []
    @lesson.lesson_transcripts.each { |x|
      if MAIN_LANGS.include? x.lang
        lesson_transcripts_main[x.lang] = x
      else
        lesson_transcripts_all << x
      end
    }
    MAIN_LANGS.map { |l| lesson_transcripts_main[l] } + lesson_transcripts_all.sort_by { |x| x.lang }
  end

  def authorize_and_build_language_maps
    @lesson = Lesson.find(params[:id])
    authorize! :edit_descriptions, @lesson

    @lesson.build_descriptions_and_translations(@languages)
    @lesson_descriptions = sort_descriptions
    @lesson_transcripts = sort_transcripts
  end

  def generate_transcript_table_of_content
    @lesson.lesson_transcripts.each do |t|
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
    sort_line += ', ' + 'lessonname asc' unless params[:sort].equal?('lessonname')
  end
end
