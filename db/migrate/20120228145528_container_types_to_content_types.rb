class ContainerTypesToContentTypes < ActiveRecord::Migration
  def self.up
    rename_table :container_types, :content_types
    add_column :content_types, :secure, :integer, :default => 0
    rename_column :lessons, :content_type_id, :content_type_id
  end

  def self.down
    rename_table :content_types, :container_types
    remove_column :container_types, :secure
    rename_column :lessons, :content_type_id, :content_type_id
  end
end
