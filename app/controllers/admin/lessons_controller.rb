class Admin::LessonsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  
  def index
    @filter = params[:filter]
    if @filter && @filter == 'all'
      @lessons = Lesson.ordered.page(params[:page])
    else
      @lessons = Lesson.need_update.ordered.page(params[:page])
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @secure = SECURITY.select{|s| s[:level] == @lesson.secure }.first[:name]
  end

  def new
    @lesson = Lesson.new
    @languages = Language.order('code3').all
    @lecturers = Lecturer.all
    @security = SECURITY.collect{|s| [ s[:name], s[:level] ] }
    @languages.each{ |l|
      @lesson.lesson_descriptions.build(:lang => l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def create
    @lesson = Lesson.new(params[:lesson])
    authorize! :create, @lesson

    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully created admin/lesson."
    else
      render :action => 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    authorize! :edit, @lesson
    @languages = Language.order('code3').all
    @lecturers = Lecturer.all
    @security = SECURITY.collect{|s| [ s[:name], s[:level] ] }
    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each{ |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    @lesson_descriptions = sort_descriptions
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize! :update, @lesson
    params[:lesson][:lesson_descriptions_attributes].delete_if{ |k, v|
      !v[:id] && v[:lessondesc].empty?
    }
    if @lesson.update_attributes(params[:lesson])
      redirect_to admin_lesson_path(@lesson), :notice  => "Successfully updated admin/lesson."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    authorize! :destroy, @lesson
    @lesson.destroy
    redirect_to admin_lessons_url, :notice => "Successfully destroyed admin/lesson."
  end

  def parse_lesson_name
    @lesson = Lesson.find(params[:id])
    sp = ::StringParser.new @lesson.lessonname
    @date = sp.date
    @language = sp.language
    @lecturer_id = Lecturer.rav.first.lecturerid if sp.lecturer_rav?
    @descriptions = sp.descriptions
  end

  private

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
