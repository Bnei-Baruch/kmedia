class VirtualLesson < ActiveRecord::Base
  has_many :lessons

  def self.last_lesson(lesson_id)
    if lesson_id.nil?
      # Return the latest lesson
      last_lesson = VirtualLesson.order('film_date DESC, position DESC').first
    else
      last_lesson = VirtualLesson.find(lesson_id)
    end

    next_lesson = VirtualLesson.where('film_date = ? AND position > ?', last_lesson.film_date, last_lesson.position).order('position ASC').first ||
        VirtualLesson.where('film_date > ?', last_lesson.film_date).order('film_date ASC, position ASC').first
    prev_lesson = VirtualLesson.where('film_date = ? AND position < ?', last_lesson.film_date, last_lesson.position).order('position DESC').first ||
        VirtualLesson.where('film_date < ?', last_lesson.film_date).order('film_date DESC, position DESC').first

    [last_lesson, prev_lesson, next_lesson]
  end

  def virtual_name
    if lessons.count == 1
      lessons.first.lesson_descriptions.select { |ld| ld.lang == 'ENG' }.first.lessondesc
    else
      "Morning Lesson @ #{film_date}"
    end
  rescue "Lesson"
  end

  def lessons_ordered_by_parts
    result = []
    list = self.lessons.count > 1 ? self.lessons.includes(:catalogs, :file_assets) : self.lessons.includes(:catalogs, :file_assets, :lesson_descriptions)
    return nil unless list

    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::PREPARATION)
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FIRST_PART)
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::SECOND_PART)
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::THIRD_PART)
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FOURTH_PART)
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FIFTH_PART)
    end

    result.flatten!
    result.compact!

    # There are no parts in this lesson, just one lesson (parashat shavua, etc.)
    result = list.all if result.blank?

    result
  end

end