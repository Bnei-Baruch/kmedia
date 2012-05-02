class CreateCategoryDescriptions < ActiveRecord::Migration
  def self.up
    create_table :category_descriptions do |t|
      t.integer :category_id
      t.string :text
      t.string :lang, limit: 3, default: 'HEB'

      t.timestamps
    end
  end

  def self.down
    drop_table :category_descriptions
  end
end
