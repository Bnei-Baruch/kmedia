class FileType < ActiveRecord::Base
  set_table_name :filetypes
  set_primary_key :typename
  scope :e2type, lambda {|ext| select(:typename).where('extlist like %?%', ext)}

  def self.ext_to_type(ext)
    e2type(ext).first.try(:typename)
  end
end
