class ChangeEpuToEpub < ActiveRecord::Migration
  def up
    FileAsset.where(filetype: 'epu').update_all(filetype: 'epub')
  end

  def down
  end
end
