class AddDeviseTokenAuthColumns < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      # Token authenticatable
      t.string :authentication_token
    end
  end

  def self.down
    remove_column :users,:authentication_token
  end
end
