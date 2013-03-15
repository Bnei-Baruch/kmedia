class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :comment
      t.timestamps
    end
  end
end
