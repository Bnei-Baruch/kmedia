class Lesson < ActiveRecord::Base
  set_primary_key :lessonid
  has_many :lesson_descriptions, :primary_key => :lessondescid, :foreign_key => :lessonid

  def self.find_by_id(*args, &block)
    self.send(:find_by_lessonid, *args, &block)
  end
end
