class Admin::LessonsController < ApplicationController
  def index
    @lessons = Lesson.order("date(created) DESC, lessonname ASC").page(params[:page])
  end

  def show
    @lesson = Lesson.find(params[:id])
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
  end

  def update
    @lesson = Lesson.find(params[:id])
    d = Date.parse( {"(1i)"=>"2010", "(2i)"=>"8", "(3i)"=>"16"}.to_a.sort.collect{|c| c[1]}.join("-") )
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
