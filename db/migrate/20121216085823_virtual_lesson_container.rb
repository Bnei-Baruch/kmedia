class VirtualLessonContainer < ActiveRecord::Migration
  def change
    # VirtualLesson has_many Lessons

    create_table :virtual_lessons do |t|
      t.date :film_date
      t.timestamps
    end

    add_column :lessons, :virtual_lesson_id, :integer
  end
end
