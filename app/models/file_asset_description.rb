class FileAssetDescription < ActiveRecord::Base
  set_table_name :filedesc
  set_primary_key :filedescid

  belongs_to :file_asset, :foreign_key => :fileid
end
