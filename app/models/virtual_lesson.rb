class VirtualLesson < ActiveRecord::Base
  has_many :lessons, conditions: { for_censorship: false }

  default_scope joins(:lessons).where(lessons: {for_censorship: false}).uniq

  belongs_to :user

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

  def virtual_name(code3)
    begin
      if lessons.count == 1
        lesson = (lessons.first.lesson_descriptions.select { |ld| ld.lang == code3 }.first || lessons.first.lesson_descriptions.select { |ld| ld.lang == 'ENG' }.first).lessondesc
      else
        I18n.t('ui.last_lesson.morning_lesson', date: film_date)
      end
    rescue
      I18n.t('ui.last_lesson.lesson')
    end
  end

  def lessons_ordered_by_parts
    result = []
    list = self.lessons.count > 1 ? self.lessons.includes(:catalogs, :file_assets) : self.lessons.includes(:catalogs, :file_assets, :lesson_descriptions)
    # remove lessons under censorship
    return nil unless list

    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::PREPARATION) && l.file_assets.secure(0).count > 0
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FIRST_PART) && l.file_assets.secure(0).count > 0
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::SECOND_PART) && l.file_assets.secure(0).count > 0
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::THIRD_PART) && l.file_assets.secure(0).count > 0
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FOURTH_PART) && l.file_assets.secure(0).count > 0
    end
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::FIFTH_PART) && l.file_assets.secure(0).count > 0
    end

    result.flatten!.compact!

    # There are no parts in this lesson, just one lesson (parashat shavua, etc.)
    result = list.all if result.blank?

    result
  end

  def self.vls_from_date(date)
    VirtualLesson.where(film_date: date).order(:position)
  end

  def self.next_position_on(date)
    VirtualLesson.where(film_date: date).count
  end
end