class Admin::LessonsController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :set_fields, :only => [:new, :create, :edit, :update, :edit_long_descr, :update_long_descr]

  def index
    @filter = params[:filter]
    if @filter && @filter == 'all'
      @lessons = Lesson.ordered.page(params[:page])
    else
      @lessons = Lesson.need_update.ordered.page(params[:page])
    end
  end

  def show
    begin
      @lesson = Lesson.find(params[:id])
    rescue
      redirect_to admin_lessons_path, :alert => "There is no Container with ID=#{params[:id]}."
      return
    end
    @secure = SECURITY.select{|s| s[:level] == @lesson.secure }.first[:name]
  end

  def new
    @lesson = Lesson.new
    @languages.each{ |l|
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
      @lesson_descriptions =  sort_descriptions
      render :action => 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson

    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each{ |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson
    if @lesson.update_attributes(params[:lesson])
      redirect_to admin_lesson_path(@lesson), :notice  => "Successfully updated admin/container."
    else
      params[:lesson][:lesson_descriptions_attributes].each do |k, v|
        @lesson.lesson_descriptions.build(v) if v[:lessondesc].blank?
      end
      @lesson_descriptions =  sort_descriptions
      render :action => 'edit'
    end
  end

  def edit_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson

    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each{ |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def update_long_descr
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson
    if @lesson.update_attributes(params[:lesson])
      redirect_to admin_lesson_path(@lesson), :notice  => "Successfully updated contaner description."
    else
      params[:lesson][:lesson_descriptions_attributes].each do |k, v|
        @lesson.lesson_descriptions.build(v) if v[:lessondesc].blank?
      end
      @lesson_descriptions =  sort_descriptions
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
    lessonname = params[:name] || Lesson.find(params[:id]).lessonname
    sp = ::StringParser.new lessonname
    @date = sp.date
    @language = sp.language
    @lecturer_id = Lecturer.rav.first.lecturerid if sp.lecturer_rav?
    @descriptions = sp.descriptions
  end

  private
  def set_fields
    @languages = Language.order('code3').all
    @lecturers = Lecturer.all
    @security = SECURITY.collect{|s| [ s[:name], s[:level] ] }
  end

  def sort_descriptions
    lesson_descriptions_main = {}
    lesson_descriptions_all = []
    @lesson.lesson_descriptions.each{|x|
      if MAIN_DESCR_LANGS.include? x.lang
        lesson_descriptions_main[x.lang] = x
      else
        lesson_descriptions_all << x
      end
    }
    MAIN_DESCR_LANGS.map{|l| lesson_descriptions_main[l]} + lesson_descriptions_all.sort_by{|x| x.lang }
  end
end
