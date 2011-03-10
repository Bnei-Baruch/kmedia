class Admin::LessonsController < ApplicationController
  def index
    @admin_lessons = Lesson.page(params[:page])
  end

  def show
    @admin_lesson = Lesson.find(params[:id])
  end

  def new
    @admin_lesson = Lesson.new
  end

  def create
    @admin_lesson = Lesson.new(params[:lesson])
    if @admin_lesson.save
      redirect_to admin_lesson_path(@admin_lesson), :notice => "Successfully created admin/lesson."
    else
      render :action => 'new'
    end
  end

  def edit
    @admin_lesson = Lesson.find(params[:id])
  end

  def update
    @admin_lesson = Lesson.find(params[:id])
    if @admin_lesson.update_attributes(params[:lesson])
      redirect_to admin_lesson_path(@admin_lesson), :notice  => "Successfully updated admin/lesson."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @admin_lesson = Lesson.find(params[:id])
    @admin_lesson.destroy
    redirect_to admin_lessons_url, :notice => "Successfully destroyed admin/lesson."
  end
end
