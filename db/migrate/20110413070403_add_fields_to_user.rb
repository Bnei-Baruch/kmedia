class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :default => ''
    add_column :users, :last_name, :string, :default => ''
  end

  def self.down
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
