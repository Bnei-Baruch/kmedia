class FileAssetDescription < ActiveRecord::Base
  self.table_name = :filedesc
  self.primary_key = :filedescid

  belongs_to :file_asset, :foreign_key => :fileid
end
