class ContentType < ActiveRecord::Base
  has_many :lessons

  CONTENT_TYPE_ID = {}
  CONTENT_TYPE = {}

  %w(all lesson lecture program song clip book declamation).each do |name|
    ct = ContentType.where(pattern: name).first
    CONTENT_TYPE_ID[name] = ct.try(:id)
    CONTENT_TYPE[name] = ct
  end

  CONTENT_PROGRAM = CONTENT_TYPE['program']
  CONTENT_BOOK = CONTENT_TYPE['book']
end
