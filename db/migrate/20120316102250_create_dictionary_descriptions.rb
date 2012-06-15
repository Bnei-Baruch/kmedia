class CreateDictionaryDescriptions < ActiveRecord::Migration
  def self.up
    create_table :dictionary_descriptions, options: 'default charset=utf8' do |t|
      t.integer :dictionary_id
      t.string :topic
      t.string :lang, limit: 3, default: 'HEB'

      t.timestamps
    end
  end

  def self.down
    drop_table :dictionary_descriptions
  end
end
