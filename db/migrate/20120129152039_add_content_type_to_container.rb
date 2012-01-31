class AddContentTypeToContainer < ActiveRecord::Migration
  def self.up
    create_table :container_types do |t|
      t.string :name
      t.string :pattern
    end
    add_column :lessons, :container_type_id, :integer
  end

  def self.down
    remove_column :lessons, :container_type_id
    drop_table :container_types
  end
end
