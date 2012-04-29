class DepartmentsMustMeUtf8 < ActiveRecord::Migration
  def up
    execute "alter table departments convert to character set utf8 collate 'utf8_general_ci'"
  end

  def down
  end
end
