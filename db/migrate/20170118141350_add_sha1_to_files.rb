class AddSha1ToFiles < ActiveRecord::Migration
  def change
    add_column :file_assets, :sha1, :string
  end
end
