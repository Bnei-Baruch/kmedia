class VirtualLesson < ActiveRecord::Base
  has_many :lessons, conditions: { for_censorship: false }

  default_scope joins(:lessons).where(lessons: {for_censorship: false}).uniq

  belongs_to :user

  def self.last_lesson(lesson_id)
    if lesson_id.nil?
      # Return the latest lesson
      last_lesson = VirtualLesson.order('film_date DESC, position DESC').first
    elsif lesson_id =~ /\d\d\d\d-\d\d-\d\d/
      last_lesson = VirtualLesson.where(film_date: lesson_id).order('position DESC').first
    else
      last_lesson = VirtualLesson.find(lesson_id)
    end

    return [nil, nil, nil] unless last_lesson

    next_lesson = VirtualLesson.where('film_date = ? AND position > ?', last_lesson.film_date, last_lesson.position).order('position ASC').first ||
        VirtualLesson.where('film_date > ?', last_lesson.film_date).order('film_date ASC, position ASC').first
    prev_lesson = VirtualLesson.where('film_date = ? AND position < ?', last_lesson.film_date, last_lesson.position).order('position DESC').first ||
        VirtualLesson.where('film_date < ?', last_lesson.film_date).order('film_date DESC, position DESC').first

    [last_lesson, prev_lesson, next_lesson]
  end

  # Get number of lesson in case there are more than one lesson on the same date
  def lesson_of
    [position, VirtualLesson.where(film_date: film_date).count]
  end

  def virtual_name
    position, total = lesson_of

    [I18n.t('ui.last_lesson.lesson'), film_date, position, total]
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
    result << list.select do |l|
      ids = l.catalogs.map(&:id)
      ids.include?(Lesson::SIXTH_PART) && l.file_assets.secure(0).count > 0
    end

    result.flatten!.compact!

    # There are no parts in this lesson, just one lesson (parashat shavua, etc.)
    result = list.all if result.blank?

    result
  end

  def self.combine(vls)
    # Move containers to the target VL and remove empty VLs
    if vls.is_a? String
      vls    = vls.split(',').map { |vl| VirtualLesson.find vl }
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
      lesson.update_attribute(:position, params[:position][index])
    end

    # Renumber VLs
    VirtualLesson.vls_from_date(target.film_date).each_with_index do |vl, index|
      vl.update_attribute :position, index rescue nil
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
