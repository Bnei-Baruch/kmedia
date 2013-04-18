class AddPlayTimeToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :playtime_secs, :integer
  end
end
