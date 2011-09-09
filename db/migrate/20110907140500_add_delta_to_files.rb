class AddDeltaToFiles < ActiveRecord::Migration
  def self.up
    add_column :files, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :files, :delta
  end
end
