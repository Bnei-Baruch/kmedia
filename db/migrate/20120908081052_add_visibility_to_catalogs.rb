class AddVisibilityToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalognode, :visible, :boolean, :default => true
    add_column :catalognode, :open, :boolean, :default => true
  end
end
