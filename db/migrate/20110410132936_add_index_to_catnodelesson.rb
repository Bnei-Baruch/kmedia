class AddIndexToCatnodelesson < ActiveRecord::Migration
  def self.up
    add_index :catnodelessons, :lessonid
  end

  def self.down
    remove_index :catnodelessons, :lessonid
  end
end
