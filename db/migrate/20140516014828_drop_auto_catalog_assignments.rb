class DropAutoCatalogAssignments < ActiveRecord::Migration
  def change
    drop_table :auto_catalog_assignments
  end
end
