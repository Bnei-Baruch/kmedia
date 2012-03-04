class AddMarkedForMergeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :marked_for_merge, :boolean
  end
end
