class Mysql2Postgres < ActiveRecord::Migration
  def change
    rename_table :catalognode, :catalogs
    rename_column :catalogs, :catalognodeid, :id
    rename_column :catalogs, :catalognodename, :name
    rename_column :catalogs, :parentnodeid, :parent_id

    rename_table :catnodedesc, :catalog_descriptions
    rename_column :catalog_descriptions, :catnodedescid, :id
    rename_column :catalog_descriptions, :catalognodename, :name
    rename_column :catalog_descriptions, :catalognodeid, :catalog_id
    rename_column :catalog_descriptions, :created, :created_at
    rename_column :catalog_descriptions, :updated, :uppdated_at

    rename_table :catnodelessons, :catalogs_containers
    rename_column :catalogs_containers, :catalognodeid, :catalog_id
    rename_column :catalogs_containers, :lessonid, :container_id

    rename_table :files, :file_assets
    rename_column :file_assets, :fileid, :id
    rename_column :file_assets, :filename, :name
    rename_column :file_assets, :filelang, :lang
    rename_column :file_assets, :filetype, :asset_type
    rename_column :file_assets, :filedate, :date
    rename_column :file_assets, :filesize, :size
    rename_column :file_assets, :created, :created_at
    rename_column :file_assets, :updated, :updated_at
    rename_column :file_assets, :filestatus, :status
    rename_column :file_assets, :fileclicks, :clicks

    rename_table :filedesc, :file_asset_descriptions
    rename_column :file_asset_descriptions, :filedescid, :id
    rename_column :file_asset_descriptions, :created, :created_at
    rename_column :file_asset_descriptions, :updated, :updated_at
    rename_column :file_asset_descriptions, :fileid, :file_id

    rename_table :filetypes, :file_types
    rename_column :file_types, :typename, :name

    rename_table :lecturer, :lecturers
    rename_column :lecturers, :lecturerid, :id
    rename_column :lecturers, :lecturername, :name
    rename_column :lecturers, :created, :created_at
    rename_column :lecturers, :updated, :updated_at

    rename_table :lecturerdesc, :lecturer_descriptions
    rename_column :lecturer_descriptions, :lecturerdescid, :id
    rename_column :lecturer_descriptions, :lecturerid, :lecturer_id
    rename_column :lecturer_descriptions, :lecturerdesc, :desc
    rename_column :lecturer_descriptions, :created, :created_at
    rename_column :lecturer_descriptions, :updated, :updated_at

    rename_table :lessondesc, :container_descriptions
    rename_column :container_descriptions, :lessondescid, :id
    rename_column :container_descriptions, :lessonid, :container_id
    rename_column :container_descriptions, :lessondesc, :container_desc
    rename_column :container_descriptions, :lessondesc_flat, :container_desc_flat
    rename_column :container_descriptions, :created, :created_at
    rename_column :container_descriptions, :updated, :updated_at

    rename_table :lessons, :containers
    rename_column :containers, :lessonid, :id
    rename_column :containers, :lessonname, :name
    rename_column :containers, :lessondate, :filmdate
    rename_column :containers, :created, :created_at
    rename_column :containers, :updated, :updated_at

    rename_table :lessonfiles, :containers_file_assets
    rename_column :containers_file_assets, :lessonid, :container_id
    rename_column :containers_file_assets, :fileid, :file_asset_id

    rename_table  :lesson_transcripts, :containers_transcripts
    rename_table  :lessondesc_patterns, :container_description_patterns
  end
end
