class SimpleController < ApplicationController

  layout 'simple'

  def index
    @language        = Language::LOCALE_CODE3[@locale]
    @virtual_lessons = VirtualLesson.order('film_date DESC').page params[:page]
  end

  def show
    @language       = Language::LOCALE_CODE3[@locale]
    @film_date      = params[:id]
    @virtual_lesson = VirtualLesson.where(film_date: @film_date).first
  end
end
