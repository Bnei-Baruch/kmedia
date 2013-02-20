class FileType < ActiveRecord::Base
  self.table_name = :filetypes
  self.primary_key = :typename
  scope :e2type, lambda { |ext| where("extlist like '%#{ext}%'") }

  # ext -> type
  EXT_TYPE = FileType.all.inject({}) do |h, f|
    f.extlist.split(',').map do |ft|
      h[ft] = f.typename
    end
    h
  end

  def self.ext_to_type(ext)
    EXT_TYPE[ext]
  end

  def self.ext_to_icon(ext)
    EXT_TYPE[ext].first.try(:pic)
  end

  def self.map_file_exts_to_types(exts)
    exts.uniq.map { |ext| ext_to_type(ext) }.uniq
  end

end
