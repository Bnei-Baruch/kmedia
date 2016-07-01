class MorningLessonController < ApplicationController
  def show
    @lang         = params[:id]

    # find the morning lessons
    search        = Search.new(content_type_id: Container::LESSON_CONTENT_TYPE_ID, date_from: Date.yesterday.to_s)
    search_result = search.search_full_text(1)
    #handle the error
    return render json: { error: search.error } unless search_result

    lessons   = search_result.results
    files     = lessons.map(&:file_assets).flatten
    @language = files.select { |f| f.lang == @lang }.group_by { |f| f.date.to_date }

    render layout: false
  end
end
