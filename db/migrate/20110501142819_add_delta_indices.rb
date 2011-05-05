class AddDeltaIndices < ActiveRecord::Migration
  def self.up
    add_column :lessons, :delta, :boolean, :default => true, :null => false
    add_column :lessondesc, :delta, :boolean, :default => true, :null => false
    add_column :catalognode, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :lessons, :delta
    remove_column :lessondesc, :delta
    remove_column :catalognode, :delta
  end
end
