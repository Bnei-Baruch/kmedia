# == Schema Information
#
# Table name: lecturer_descriptions
#
#  id          :integer          not null, primary key
#  lecturer_id :integer          default(0), not null
#  desc        :string(100)      not null
#  lang        :string(3)        not null
#  created_at  :datetime
#  updated_at  :datetime
#

class LecturerDescription < ActiveRecord::Base

  scope :by_id_and_language, ->(id, language) { where(id: id).where(lang: language)}

  def to_s
    desc
  end
end
