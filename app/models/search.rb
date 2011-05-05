# Please note that there is NO DB TABLE for this class
class Search < ActiveRecord::Base
  def self.columns()
    @columns ||= [];
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :search, :string
end
