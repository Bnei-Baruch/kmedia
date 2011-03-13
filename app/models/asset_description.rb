class AssetDescription < ActiveRecord::Base
  set_table_name :filedesc
  set_primary_key :filedescid

  belongs_to :asset, :foreign_key => :fileid
end
