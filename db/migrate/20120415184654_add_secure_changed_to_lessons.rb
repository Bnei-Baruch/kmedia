class AddSecureChangedToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :secure_changed, :boolean, :default => false
  end
end
