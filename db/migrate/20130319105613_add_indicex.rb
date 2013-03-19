class AddIndicex < ActiveRecord::Migration
  def change
    add_index :lessons, :virtual_lesson_id
  end
end
