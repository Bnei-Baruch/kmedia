module SearchesHelper
  def best_hit_description(hit)
    if highlight = hit.highlight(:body)
      highlight.format { |word| "<strong>#{word}</strong>" }
    else
      result = hit.result
      klass = result.class
      case
        when klass == Asset
          result.filename
        when klass == Lesson
          result.lessonname
        when klass == LessondescPattern
          result.description
        when klass == LessonDescription
          result.lessondesc
        when klass == Catalog
          result.catalognodename.gsub(/\//, ' / ')
        else
          ''
      end
    end
  end
end