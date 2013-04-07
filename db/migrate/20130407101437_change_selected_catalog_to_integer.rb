class ChangeSelectedCatalogToInteger < ActiveRecord::Migration
  def change
    change_column :catalognode, :selected_catalog, :integer
  end
end
