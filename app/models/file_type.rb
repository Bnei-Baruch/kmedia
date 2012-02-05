class FileType < ActiveRecord::Base
  set_table_name :filetypes
  set_primary_key :typename
  scope :e2type, lambda {|ext| where("extlist like '%#{ext}%'")}

  def self.ext_to_type(ext)
    e2type(ext).first.try(:typename)
  end

  def self.ext_to_icon(ext)
    e2type(ext).first.try(:pic)
  end
end
