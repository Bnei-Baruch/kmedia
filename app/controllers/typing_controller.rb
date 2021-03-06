class TypingController < ApplicationController

  layout 'typing'

  def index
    @menu_languages        = Language.menu_languages(Language::UI_LANGUAGES).map { |x| [x['language'], typing_index_url(x['locale'])] }
    @current_menu_language = typing_index_url(@locale)

    @language    = Language::LOCALE_CODE3[@locale]
    @container_date = params[:container_date] || Date.today

    @last_lectures_programs = Container.last_lectures_programs(@container_date, @language)

    vl            = VirtualLesson.last_lesson(@container_date)
    @last_lessons = vl ? vl.lessons_ordered_by_parts : []
  end

end
