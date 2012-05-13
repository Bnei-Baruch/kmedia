class AddFlagForAutoParsedContainers < ActiveRecord::Migration
  def change
    add_column :lessons, :auto_parsed, :boolean, :default => false
  end
end
