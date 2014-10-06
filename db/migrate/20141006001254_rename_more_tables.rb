class RenameMoreTables < ActiveRecord::Migration
  def change
    rename_table :containers_transcripts, :container_transcripts
    rename_column :container_transcripts, :lessonid, :container_id
    rename_column :catalogs, :created, :created_at
    rename_column :catalogs, :updated, :updated_at
    rename_column :catalog_descriptions, :uppdated_at, :updated_at
  end
end
