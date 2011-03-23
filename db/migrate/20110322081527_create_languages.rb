class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :locale
      t.string :code3
      t.string :language
    end
  end

  def self.down
    drop_table :languages
  end
end
