class AddBooksCatalogField < ActiveRecord::Migration
  def change
    add_column :catalognode, :books_catalog, :boolean
  end
end
