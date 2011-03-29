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
    @lesson.lesson_descriptions.sort!{|x, y|
      if MAIN_DESCR_LANGS.include? x.lang
        if MAIN_DESCR_LANGS.include? y.lang
          MAIN_DESCR_LANGS.index(x.lang) <=> MAIN_DESCR_LANGS.index(y.lang)
        else
          -1
        end
      else
        x.lang <=> y.lang
      end
    }
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

end
