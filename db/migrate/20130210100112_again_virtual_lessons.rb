class AgainVirtualLessons < ActiveRecord::Migration
  def up
    say 'Remove virtual lessons'
    VirtualLesson.delete_all(' true')
    say 'Remove links to virtual lessons'
    Lesson.update_all 'virtual_lesson_id = "nil"'

    say 'Recreate virtual lessons'
    Lesson.where('secure < 1').where('lessondate is not null').order('lessondate ASC, created ASC').each { |container|
      vl = Lesson.create_virtual_lesson(container)
      if vl.nil?
        say("############# Lesson: id: #{container.id}")
      else
        container.save
        say("Lesson: id: #{container.id} vl.id: #{vl.id} vl.pos: #{vl.position}")
      end
    }
  end

  def down
  end
end
