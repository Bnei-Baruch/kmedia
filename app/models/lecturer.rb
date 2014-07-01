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
