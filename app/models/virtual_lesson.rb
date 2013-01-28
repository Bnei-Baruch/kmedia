class VirtualLesson < ActiveRecord::Base
  has_many :lessons

  acts_as_list :scope => "film_date"

  def self.last_lesson(before_lesson, after_lesson)
    if before_lesson
      next_lesson = true

      last_lesson = VirtualLesson.find(before_lesson)
      ll = last_lesson.lower_item
      unless ll
        ll = VirtualLesson.where('film_date < ?', last_lesson.film_date).order('film_date DESC, position ASC').first
      end
      prev_lesson = ll
    elsif after_lesson
      prev_lesson = true

      last_lesson = VirtualLesson.find(after_lesson)
      ll = last_lesson.higher_item
      unless ll
        ll = VirtualLesson.where('film_date > ?', last_lesson.film_date).order('film_date DESC, position ASC').last
      end
      next_lesson = ll
    else
      ll = VirtualLesson.order('film_date DESC, position ASC').first
      next_lesson = false
      prev_lesson = VirtualLesson.last_lesson(ll.id, nil)
    end
    [ll, prev_lesson, next_lesson]
  end

end