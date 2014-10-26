class RemoveFlattening < ActiveRecord::Migration
  def change
    remove_column :container_descriptions, :container_desc_flat
    remove_column :container_descriptions, :descr_flat
  end
end
