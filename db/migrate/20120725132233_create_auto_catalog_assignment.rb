class CreateAutoCatalogAssignment < ActiveRecord::Migration
  def change
    create_table :auto_catalog_assignments do |t|
      t.integer :counter, :default => -1
      t.datetime :last_date
      t.timestamps
    end
  end
end
