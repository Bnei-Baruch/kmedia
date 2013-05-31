class ChangeFileTypeToVarchar10 < ActiveRecord::Migration
  def up
    #ALTER TABLE YourTable MODIFY COLUMN YourField Char(6)
    change_column :files, :filetype, :string, limit: 10 # VARCHAR(10)
  end

  def down
    change_column :files, :filetype, :string, limit: 3 # CHAR(3)
  end
end
