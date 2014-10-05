class FileAssetDescription < ActiveRecord::Base
  belongs_to :file_asset

  def to_s
    filedesc
  end
end
