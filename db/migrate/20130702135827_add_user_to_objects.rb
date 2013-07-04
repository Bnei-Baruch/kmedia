class AddUserToObjects < ActiveRecord::Migration
  def change
    add_column :lessons, :user_id, :integer rescue nil
    add_column :lessondesc_patterns, :user_id, :integer rescue nil
    add_column :catalognode, :user_id, :integer rescue nil
    add_column :files, :user_id, :integer rescue nil
    add_column :virtual_lessons, :user_id, :integer rescue nil
  end
end
