class AddDeltaToLessonDescPatterns < ActiveRecord::Migration
  def self.up
    add_column :lessondesc_patterns, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :lessondesc_patterns, :delta
  end
end
