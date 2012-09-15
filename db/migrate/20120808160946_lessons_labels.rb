class LessonsLabels < ActiveRecord::Migration
  def up
    create_table 'lessons_labels', :id => false do |t|
      t.references :lesson, null: false
      t.references :label, null: false
    end

    add_index :lessons_labels, [:lesson_id, :label_id], uniq: true
    add_index :lessons_labels, :label_id
  end

  def down
    drop_table 'lessons_labels'
  end
end
