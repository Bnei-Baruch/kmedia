# == Schema Information
#
# Table name: file_asset_descriptions
#
#  id         :integer          not null, primary key
#  file_id    :integer          default(0), not null
#  filedesc   :string(255)
#  lang       :string(3)
#  created_at :datetime
#  updated_at :datetime
#

class FileAssetDescription < ActiveRecord::Base
  belongs_to :file_asset

  def to_s
    filedesc
  end
end
