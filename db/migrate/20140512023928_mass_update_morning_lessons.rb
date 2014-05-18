class MassUpdateMorningLessons < ActiveRecord::Migration
  def up
    catalog_lesson_part = Catalog.where(catalognodename: 'lessons-part').first
    catalog_preparation = Catalog.where(catalognodename: 'lesson_preparation').first
    lesson_parts        = catalog_lesson_part.descendant_catalogs(false) - [catalog_preparation]

    remove_column :virtual_lessons, :position

    VirtualLesson.group(:film_date).count.select { |k, v| v > 1 }.keys.map { |d| d.to_s('%Y-%m-%d') }.each do |film_date|
      say "Film date: #{film_date}"
      # 1. Join all morning lessons from the same date and give position to containers inside it
      vls = VirtualLesson.where(film_date: film_date)
      say "\t found"
      VirtualLesson.combine(vls) rescue next
      say "\t combined"
      vls[0].lessons.order('position ASC').each_with_index do |lesson, index|
        lesson.update_attribute(:position, index + 1)
        say "\t position updated"
        # 2. Move all parts from catalogs 'lesson_xxx-part' to their father 'lessons-part'; keep 'lesson_preparation' for preparation part
        lesson.catalogs -= lesson_parts
        lesson.catalogs << catalog_lesson_part
        say "\t catalogs updated"
      end
    end
  end

  def down
  end
end
