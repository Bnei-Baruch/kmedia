class AddLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :dictionary_id
      t.string :suid, limit: 20

      t.timestamps
    end
    rename_table :labels_lessons, :containers_labels
    rename_column :containers_labels, :lesson_id, :container_id
  end
end
