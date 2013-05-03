class LecturerDescription < ActiveRecord::Base
  self.table_name = :lecturerdesc
  self.primary_key = :lecturerdescid

  scope :by_lecturerid_and_language, ->(lecturerid, language) { where(lecturerid: lecturerid).where(lang: language)}

  def to_s
    lecturerdesc
  end
end
