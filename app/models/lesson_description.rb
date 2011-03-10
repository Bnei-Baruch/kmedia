class LessonDescription < ActiveRecord::Base
  set_table_name :lessondesc
  set_primary_key :lessondescid
  belongs_to :lesson, :foreign_key => :lessonid, :primary_key => :lessonid

  def self.find_by_id(*args, &block)
    self.send(:find_by_lessondescid, *args, &block)
  end

end
