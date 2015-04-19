# == Schema Information
#
# Table name: virtual_lessons
#
#  id         :integer          not null, primary key
#  film_date  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class VirtualLesson < ActiveRecord::Base
  has_many :containers, conditions: { for_censorship: false, secure: 0 }, order: 'position ASC'

  default_scope joins(:containers).where(containers: { for_censorship: false, secure: 0 }).uniq

  belongs_to :user

  def self.last_lesson(lesson_id = nil)
    if lesson_id.nil?
      # Return the latest lesson
      VirtualLesson.order('"virtual_lessons".film_date DESC').first
    elsif lesson_id.to_s =~ /\d\d\d\d-\d\d-\d\d/
      # that's date, not id...
      VirtualLesson.where(film_date: lesson_id).first
    else
      VirtualLesson.where(id: lesson_id).first
    end
  end

  def self.next_lesson(film_date)
    VirtualLesson.where('film_date > ?', film_date).order('"virtual_lessons".film_date ASC').first
  end

  def self.prev_lesson(film_date)
    VirtualLesson.where('film_date < ?', film_date).order('"virtual_lessons".film_date DESC').first
  end

  def lessons_ordered_by_parts
    list = self.containers.count > 1 ? self.containers.includes(:catalogs, :file_assets) : self.containers.includes(:catalogs, :file_assets, :container_descriptions)
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
      vl.containers.each do |lesson|
        target.containers << lesson
      end
      vl.destroy
    end

    # Renumber containers in the target VL
    target.containers.order('position ASC').each_with_index do |lesson, index|
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
