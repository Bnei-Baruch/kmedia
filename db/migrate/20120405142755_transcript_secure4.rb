class TranscriptSecure4 < ActiveRecord::Migration
  def up
    t = ContentType.find_by_name('Transcript')
    t.update_attribute(:secure, 4) if t
  end

  def down
  end
end
