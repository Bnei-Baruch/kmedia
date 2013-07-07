class AddCensorshipToContainers < ActiveRecord::Migration
  def change
    add_column :lessons, :for_censorship, :boolean, :default => false
    add_column :lessons, :opened_by_censor, :boolean, :default => false
    add_column :lessons, :closed_by_censor, :boolean, :default => false
    add_column :lessons, :censor_id, :integer
  end
end
