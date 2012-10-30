class CreateLabelsLessonsJoinTable < ActiveRecord::Migration
  def up
    create_table 'labels_lessons', :id => false do |t|
      t.references :label, null: false
      t.references :lesson, null: false
    end

    add_index :labels_lessons, [:label_id, :lesson_id], uniq: true
    add_index :labels_lessons, :lesson_id
  end

  def down
    drop_table 'labels_lessons'
  end
end
