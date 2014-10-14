# == Schema Information
#
# Table name: lecturers
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  created_at :datetime
#  updated_at :datetime
#  ordnum     :integer          default(0), not null
#

class Lecturer < ActiveRecord::Base
  has_many :lecturer_descriptions
  has_many :lessons

  scope :rav, where('name ILIKE \'%rav%\'').limit(1)

  def to_param
    read_attribute :id
  end

  def to_s
    name
  end
end
