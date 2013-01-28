class ChangeVirtualLessonsSetup < ActiveRecord::Migration
  def up

    say 'Add column'
    add_column :virtual_lessons, :position, :integer

    say 'Remove secure virtual lessons'
    vlids = Lesson.where('secure > 0').all.map(&:virtual_lesson_id).compact.sort.uniq
    Lesson.where('secure > 0').update_all(:virtual_lesson_id => nil)

    say 'Remove virtual lessons'
    remove_ids = VirtualLesson.where(id: vlids).includes(:lessons).reject{|vl| vl.lessons.present?}.map(&:id)
    VirtualLesson.where(id: remove_ids).delete_all
  end

  def down
    remove_column :virtual_lessons, :position
  end
end
