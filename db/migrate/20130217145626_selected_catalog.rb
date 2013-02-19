class SelectedCatalog < ActiveRecord::Migration
  def change
    add_column :catalognode, :selected_catalog, :boolean
  end
end
