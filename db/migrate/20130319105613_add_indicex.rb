class AddIndicex < ActiveRecord::Migration
  def change
    add_index :languages, :virtual_lesson_id
  end
end
