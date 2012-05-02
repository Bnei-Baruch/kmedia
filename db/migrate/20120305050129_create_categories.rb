class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :dictionary_id
      t.string :suid, limit: 20

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
