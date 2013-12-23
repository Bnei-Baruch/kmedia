class ContentType < ActiveRecord::Base
  has_many :lessons

  CONTENT_TYPE_ID = {}

  %w(all lesson lecture program song clip book declamation).each do |name|
    ct = ContentType.where(pattern: name).first
    CONTENT_TYPE_ID[name] = ct.try(:id)
  end

  CONTENT_PROGRAM = CONTENT_TYPE_ID['program']
  CONTENT_BOOK = CONTENT_TYPE_ID['book']
end
