class CreateLabelDescriptions < ActiveRecord::Migration
  def self.up
    create_table :label_descriptions do |t|
      t.integer :label_id
      t.string :text
      t.string :lang, limit: 3, default: 'HEB'

      t.timestamps
    end
  end

  def self.down
    drop_table :label_descriptions
  end
end
