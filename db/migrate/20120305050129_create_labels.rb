class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.integer :dictionary_id
      t.string :suid, limit: 20

      t.timestamps
    end
  end

  def self.down
    drop_table :labels
  end
end
