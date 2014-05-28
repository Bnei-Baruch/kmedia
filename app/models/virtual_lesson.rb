class VirtualLesson < ActiveRecord::Base
  has_many :lessons, conditions: { for_censorship: false, secure: 0 }, order: 'position ASC'

  default_scope joins(:lessons).where(lessons: { for_censorship: false, secure: 0 }).uniq

  belongs_to :user

  def self.last_lesson(lesson_id)
    if lesson_id.nil?
      # Return the latest lesson
      VirtualLesson.order('film_date DESC').first
    elsif lesson_id.to_s =~ /\d\d\d\d-\d\d-\d\d/
      # that's date, not id...
      VirtualLesson.where(film_date: lesson_id).first
    else
      VirtualLesson.find(lesson_id)
    end
  end

  def self.next_lesson(film_date)
    VirtualLesson.where('film_date > ?', film_date).order('film_date ASC').first
  end

  def self.prev_lesson(film_date)
    VirtualLesson.where('film_date < ?', film_date).order('film_date DESC').first
  end

  def lessons_ordered_by_parts
    list = self.lessons.count > 1 ? self.lessons.includes(:catalogs, :file_assets) : self.lessons.includes(:catalogs, :file_assets, :lesson_descriptions)
    # remove lessons under censorship
    return nil unless list

    result = list.order('position ASC').inject([]) { |memo, l|
      memo << l if l.file_assets.secure(0).count > 0
      memo
    }.compact!

    # There are no parts in this lesson, just one lesson (parashat shavua, etc.)
    result = list.all if result.blank?

    result
  end

  def self.combine(vls)
    # Move containers to the target VL and remove empty VLs
    if vls.is_a? String
      vls = vls.split(',').map { |vl| VirtualLesson.find vl }
    end
    target = vls.shift
    vls.each do |vl|
      vl.lessons.each do |lesson|
        target.lessons << lesson
      end
      vl.destroy
    end

    # Renumber containers in the target VL
    target.lessons.order('position ASC').each_with_index do |lesson, index|
      lesson.update_attribute(:position, index)
    end

    "Container(s) #{vls.map(&:id).join(',')} were successfully moved to #{target.id}"
  end

  def self.vls_from_date(date)
    VirtualLesson.where(film_date: date).order(:position)
  end

  def self.next_position_on(date)
    VirtualLesson.where(film_date: date).count
  end
end
