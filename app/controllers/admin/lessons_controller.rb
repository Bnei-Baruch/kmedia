class Admin::LessonsController < Admin::ApplicationController
  before_filter :set_fields, :only => [:new, :create, :edit, :update, :edit_long_descr, :update_long_descr,]

  def index
    @filter = params[:filter]
    @lessons = if @filter && @filter == 'all'
                 Lesson
               elsif @filter && @filter == 'secure_changed'
                 Lesson.secure_changed
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
    }
    @lesson_descriptions = sort_descriptions
  end

  def create
    @lesson = Lesson.new(params[:lesson])
    authorize! :create, @lesson
    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully created admin/container."
    else
      params[:lesson][:lesson_descriptions_attributes].each do |k, v|
        @lesson.lesson_descriptions.build(v) if v[:lessondesc].blank?
      end
      @lesson_descriptions = sort_descriptions
      render :action => 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson

    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each { |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson

    @lesson.attributes = params[:lesson]
    if operator_changed_secure_field?
      @lesson.secure_changed=true
    end

    @lesson.auto_parsed = false

    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated admin/container."
    else
      params[:lesson][:lesson_descriptions_attributes].each do |k, v|
        @lesson.lesson_descriptions.build(v) if v[:lessondesc].blank?
      end
      @lesson_descriptions = sort_descriptions
      render :action => 'edit'
    end
  end

  def edit_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson

    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each { |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def update_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson
    if @lesson.update_attributes(params[:lesson])
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully updated contaner description."
    else
      params[:lesson][:lesson_descriptions_attributes].each do |k, v|
        @lesson.lesson_descriptions.build(v) if v[:lessondesc].blank?
      end
      @lesson_descriptions = sort_descriptions
      render :action => 'edit'
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
    merge_ids = params[:lesson][:container_ids].map(&:to_i) #.reject{|m| m == 0}
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
    lesson_descriptions_main = { }
    lesson_descriptions_all = []
    @lesson.lesson_descriptions.includes(:language).each { |x|
      if MAIN_DESCR_LANGS.include? x.lang
        lesson_descriptions_main[x.lang] = x
      else
        lesson_descriptions_all << x
      end
    }
    MAIN_DESCR_LANGS.map { |l| lesson_descriptions_main[l] } + lesson_descriptions_all.sort_by { |x| x.lang }
  end

  def operator_changed_secure_field?
    if @current_user.role?(:operator)
      changed_fields = @lesson.changes
      return changed_fields.size == 1  && (changed_fields.has_key? ("secure"))
    end
    return false
  end

end
