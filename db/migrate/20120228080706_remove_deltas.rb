class RemoveDeltas < ActiveRecord::Migration
  def self.up
    remove_column :lessons, :delta
    remove_column :lessondesc, :delta
    remove_column :catalognode, :delta
    remove_column :lessondesc_patterns, :delta
    remove_column :files, :delta
  end

  def self.down
    add_column :lessons, :delta, :boolean, :default => true, :null => false
    add_column :lessondesc, :delta, :boolean, :default => true, :null => false
    add_column :catalognode, :delta, :boolean, :default => true, :null => false
    add_column :lessondesc_patterns, :delta, :boolean, :default => true, :null => false
    add_column :files, :delta, :boolean, :default => true, :null => false
  end
end
