class CreateLessondescPatterns < ActiveRecord::Migration
  def self.up
    create_table :lessondesc_patterns do |t|
      t.string :pattern
      t.string :description
      t.string :lang
      t.timestamps
    end
  end

  def self.down
    drop_table :lessondesc_patterns
  end
end
