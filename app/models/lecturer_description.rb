class LecturerDescription < ActiveRecord::Base

  scope :by_id_and_language, ->(id, language) { where(id: id).where(lang: language)}

  def to_s
    desc
  end
end
