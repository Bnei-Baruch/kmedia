# encoding: UTF-8
class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments, :options => "DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci" do |t|
      t.string :name
      t.timestamps
    end
  end
end
