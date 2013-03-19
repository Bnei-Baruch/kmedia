class ContentType < ActiveRecord::Base
  has_many :lessons

  CONTENT_TYPE_ID = {}

  %w(all lesson lecture program song clip book declamation
    lesson_preparation lesson_first-part lesson_second-part lesson_third-part lesson_fourth-part lesson_fifth-part).each do |name|
    ct = ContentType.find_by_pattern(name)
    CONTENT_TYPE_ID[name] = ct.try(:id)
  end

end
