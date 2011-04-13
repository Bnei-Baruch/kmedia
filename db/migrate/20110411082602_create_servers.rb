class CreateServers < ActiveRecord::Migration
  def self.up
    execute 'alter table servers drop primary key;'
    add_column :servers, :id, :primary_key
    add_index :servers, :servername, :unique => true
  end

  def self.down
    remove_column :servers, :id
    remove_index :servers, :servername
    execute("alter table servers add primary key servername;")
  end
end
