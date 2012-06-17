class Admin::LessonsController < Admin::ApplicationController
  before_filter :set_fields, :only => [:new, :create, :edit, :update, :edit_long_descr, :update_long_descr, :edit_transcript, :update_transcript]

  def index
    @filter = params[:filter]
    @lessons = if @filter && @filter == 'all'
                 Lesson
               elsif @filter && @filter == 'secure_changed'
                 Lesson.secure_changed
               elsif @filter && @filter == 'no_files'
                 Lesson.no_files
               else
                 Lesson.need_update
               end.ordered.page(params[:page])
  end

  def show
    begin
      @lesson = Lesson.find(params[:id])
    rescue
      redirect_to admin_lessons_path, :alert => "There is no Container with ID=#{params[:id]}."
      return
    end
    @secure = SECURITY.select { |s| s[:level] == @lesson.secure }.first[:name]
  end

  def new
    @lesson = Lesson.new
    @lesson.catalogs << @rss # Add it to RSS by default
    @languages.each { |l|
      @lesson.lesson_descriptions.build(:lang => l.code3)
      @lesson.lesson_transcripts.build(:lang => l.code3)
    }
    @lesson_descriptions = sort_descriptions
    @lesson_transcripts = sort_transcripts
  end

  def create
    @lesson = Lesson.new(params[:lesson])
    authorize! :create, @lesson
    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully created admin/container."
    else
      @lesson_descriptions = sort_descriptions
      @lesson_transcripts = sort_transcripts
      render :action => 'new'
    end
  end

  def edit
    authorize_and_build_language_maps
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson

    @lesson.attributes = params[:lesson]
    @lesson.secure_changed = operator_changed_secure_field?

    @lesson.auto_parsed = false

    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated admin/container."
    else 
      @lesson_descriptions = sort_descriptions
      @lesson_transcripts = sort_transcripts
      render :action => 'edit'
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
    authorize! :update, @lesson

    @lesson.attributes = params[:lesson]
    generate_transcript_table_of_content
    if @lesson.lesson_transcripts.each(&:save)
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated container transcript."
    else
      @lesson_transcripts = sort_transcripts
      render :action => 'edit_transcript'
    end
  end

  def update_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson
    @lesson.attributes = params[:lesson]
    if @lesson.lesson_descriptions.each(&:save)
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated container long description."
    else
      @lesson_descriptions = sort_descriptions
      render :action => 'edit_long_descr'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    authorize! :destroy, @lesson
    @lesson.destroy
    redirect_to admin_lessons_url, :notice => "Successfully destroyed admin/container."
  end

  def parse_lesson_name
    if params[:name].blank? && params[:id].blank?
      render :text => 'alert("Empty Container Name");'
      return
    end
    lessonname = params[:name] || Lesson.find(params[:id]).lessonname
    sp = ::StringParser.new lessonname
    @date = sp.date
    @language = sp.language
    @lecturerid = Lecturer.rav.first.lecturerid if sp.lecturer_rav?
    @descriptions = sp.descriptions
    @catalogs = @descriptions.select {|d| !d.catalogs.empty?}.first.try(:catalogs)
    @content_type_id = sp.content_type.id
    @security = sp.content_security_level
    render :parse_lesson_name, :layout => false
  end

  alias :parse_new_lesson_name :parse_lesson_name

  def mark_for_merge
    begin
      lesson = Lesson.find(params[:id])
    rescue
      render :js => 'alert("No such lesson")';
      return
    end
    lesson.marked_for_merge = !lesson.marked_for_merge
    lesson.update_attribute(:marked_for_merge, lesson.marked_for_merge)
    render :js => lesson.marked_for_merge ?
        "$('.mark_for_merge').addClass('btn-warning').text('Unmark')" :
        "$('.mark_for_merge').removeClass('btn-warning').text('Mark')"
  end

  def merge_get_list
    @lesson = Lesson.find(params[:id])
    unless @lesson
      render :nothing => true
      return
    end
    @lessons = Lesson.where(:marked_for_merge => true)
    if @lessons.count == 0
      render :text => 'empty'
      return
    end
    if @lessons.map(&:id).include? @lesson.id
      # Recursion
      render :text => 'recursion'
      return
    end

    render :layout => false
  end

  def merge
    @lesson = Lesson.find(params[:id])
    merge_ids = params[:lesson][:container_ids].map(&:to_i)
    merges = Lesson.where(:lessonid => merge_ids).each { |merge|
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

  private
  def set_fields
    @languages = Language.order('code3').all
    @lecturers = Lecturer.all
    @content_types = ContentType.all.map { |ct| [ct.name, ct.id] }
    @security = SECURITY.collect { |s| [s[:name], s[:level]] }
    @rss = Catalog.find_by_catalognodename('Video')
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

  def operator_changed_secure_field?
    if @current_user.role?(:operator)
      changed_fields = @lesson.changes
      return changed_fields.size == 1 && (changed_fields.has_key? ("secure"))
    end
    return false
  end

  def authorize_and_build_language_maps
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson

    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    transcript_lang_codes = @lesson.lesson_transcripts.map(&:lang)
    @languages.each { |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
      @lesson.lesson_transcripts.build(:lang => l.code3) unless  transcript_lang_codes.include?(l.code3)

    }
    @lesson_descriptions = sort_descriptions
    @lesson_transcripts = sort_transcripts
  end

  def generate_transcript_table_of_content
    @lesson.lesson_transcripts.each do |t|
      doc = Nokogiri::HTML.parse(t.transcript)
      toc=""
      doc.xpath('//h1').each do |h_tag|
        toc = toc << "<br/>" if !toc.empty?
        toc = toc + h_tag.content
      end
      t.toc = toc
    end
  end

  def get_catalogs_from_matched_description_patterns
    @descriptions.each do |d|
      return d.catalogs unless d.catalogs.empty?
    end
    return nil
  end

end
