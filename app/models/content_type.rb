class ContentType < ActiveRecord::Base
  has_many :lessons

  CONTENT_TYPE_ID = {}

  %w(all lesson lecture program song clip book declamation).each do |name|
    ct = ContentType.where(pattern: name).first
    CONTENT_TYPE_ID[name] = ct.try(:id)
  end

  ContentType::CONTENT_PROGRAM = ContentType.find_by_pattern('program')
end
