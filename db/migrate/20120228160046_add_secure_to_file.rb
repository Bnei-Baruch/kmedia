class AddSecureToFile < ActiveRecord::Migration
  def change
    add_column :files, :secure, :integer, :default => 0
  end
end
