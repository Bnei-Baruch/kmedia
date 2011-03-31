class Admin::LessonsController < ApplicationController
  layout 'admin'

  def index
    @lessons = Lesson.order("date(created) DESC, lessonname ASC").page(params[:page])
  end

  def show
    @lesson = Lesson.find(params[:id])

    @secure = SECURITY.select{|s| s[:level] == @lesson.secure }.first[:name]
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(params[:lesson])
    if @lesson.save
      redirect_to admin_lesson_path(@lesson), :notice => "Successfully created admin/lesson."
    else
      render :action => 'new'
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @languages = Language.order('code3').all
    @lecturers = Lecturer.all
    @security = SECURITY.collect{|s| [ s[:name], s[:level] ] }
    lang_codes = @lesson.lesson_descriptions.map(&:lang)
    @languages.each{ |l|
      @lesson.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
    }
    lesson_descriptions_main = lesson_descriptions_all = []
    @lesson.lesson_descriptions.each{|x|
      if MAIN_DESCR_LANGS.include? x.lang
        lesson_descriptions_main << x
      else
        lesson_descriptions_all << x
      end
    }
    @lesson.lesson_descriptions = lesson_descriptions_main + lesson_descriptions_all.sort_by{|x| x.lang }
  end

  def update
    @lesson = Lesson.find(params[:id])
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
    @lesson.destroy
    redirect_to admin_lessons_url, :notice => "Successfully destroyed admin/lesson."
  end

  def parse_lesson_name
    @lesson = Lesson.find(params[:id])
    sp = ::StringParser.new @lesson.lessonname
    @date = sp.date
    @language = sp.language
    @change_date = !@lesson.lessondate?
    @change_lang = !@lesson.lang? || @lesson.lang.empty?
  end
end
