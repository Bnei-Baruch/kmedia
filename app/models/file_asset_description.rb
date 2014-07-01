class FileAssetDescription < ActiveRecord::Base
  belongs_to :file_asset

  def to_s
    desc
  end
end
