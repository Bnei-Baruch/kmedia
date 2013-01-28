class CreateVirtualLessons < ActiveRecord::Migration
  LESSON_CONTENT_TYPE_ID = ContentType.find_by_pattern('lesson').id
  PREPARATION = Catalog.find_by_catalognodename('lesson_preparation').id
  FIRST_PART = Catalog.find_by_catalognodename('lesson_first-part').id
  SECOND_PART = Catalog.find_by_catalognodename('lesson_second-part').id
  THIRD_PART = Catalog.find_by_catalognodename('lesson_third-part').id
  FOURTH_PART = Catalog.find_by_catalognodename('lesson_fourth-part').id
  FIFTH_PART = Catalog.find_by_catalognodename('lesson_fifth-part').id

  def up

    Lesson.where(content_type_id: LESSON_CONTENT_TYPE_ID).where(virtual_lesson_id: nil).where('lessondate IS NOT NULL').order('lessondate asc, created asc').all.each do |lesson|
      printf 'Lesson %d: ' % lesson.id
      case
        when lesson.catalogs.map(&:id).include?(PREPARATION)
          # preparation - create new container
          vl = VirtualLesson.new
          vl.film_date = lesson.lessondate
          vl.save
          lesson.update_attribute(:virtual_lesson, vl)
          printf "PREPARATION, new VL %d\n" % vl.id
        when lesson.catalogs.map(&:id).include?(FIRST_PART)
          # first_part - create a new container or add to last_container
          printf 'FIRST PART'
          vl = VirtualLesson.last
          if vl.film_date != lesson.lessondate
            vl = VirtualLesson.new
            vl.film_date = lesson.lessondate
            vl.save
            printf ', new'
          end
          printf " VL %d\n" % vl.id
          lesson.update_attribute(:virtual_lesson, vl)
        when lesson.catalogs.map(&:id).include?(SECOND_PART) ||
            lesson.catalogs.map(&:id).include?(THIRD_PART) ||
            lesson.catalogs.map(&:id).include?(FOURTH_PART) ||
            lesson.catalogs.map(&:id).include?(FIFTH_PART)

          # second_part...fifth_part - add to last_container
          vl = VirtualLesson.last
          if vl.film_date != lesson.lessondate
            # non-first part comes first... happens...
            vl = VirtualLesson.new
            vl.film_date = lesson.lessondate
            vl.save
          end
          lesson.update_attribute(:virtual_lesson, vl)
          printf "2..5 PART, VL %d\n" % vl.id
        else
          # nothing special -- just create a new container
          vl = VirtualLesson.new
          vl.film_date = lesson.lessondate
          vl.save
          lesson.update_attribute(:virtual_lesson, vl)
          printf ", VL %d\n" % vl.id
      end
    end
  end

  def down
    say 'Remove lessons'
    Lesson.update_all(:virtual_lesson_id => nil)

    say 'Remove virtual lessons'
    VirtualLesson.delete_all

  end
end
