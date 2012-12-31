class AddPlaytimeSecsToFileAsset < ActiveRecord::Migration
  def change
    add_column :files, :playtime_secs, :integer
  end
end
