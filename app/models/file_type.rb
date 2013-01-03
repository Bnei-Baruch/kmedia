class FileType < ActiveRecord::Base
  self.table_name = :filetypes
  self.primary_key = :typename
  scope :e2type, lambda {|ext| where("extlist like '%#{ext}%'")}

  def self.ext_to_type(ext)
    e2type(ext).first.try(:typename)
  end

  def self.ext_to_icon(ext)
    e2type(ext).first.try(:pic)
  end

  def self.map_file_exts_to_types(exts)
    exts.map{|ext| ext_to_type(ext)}.uniq
  end

end
