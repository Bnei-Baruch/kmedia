class AddLabelToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalognode, :label, :string
  end
end
