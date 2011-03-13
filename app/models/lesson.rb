class Lesson < ActiveRecord::Base
  set_primary_key :lessonid
  has_many :lesson_descriptions, :foreign_key => :lessonid
  has_and_belongs_to_many :assets, :join_table => "lessonfiles", :foreign_key => "lessonid",
                          :association_foreign_key => "fileid", :order => "date(updated) DESC, filename ASC"
  attr_accessor :lessondate
#  attr_accessible :lessonid, :lessonname, :created, :updated, :lessondate, :lang, :lecturerid, :secure
  
#  def self.find_by_id(*args, &block)
#    self.send(:find_by_lessonid, *args, &block)
#  end
  def before_create
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def before_update
    write_attribute :updated, Time.now
  end

  def lessondate
#    'ee'
    read_attribute :lessondate
#  rescue
#    self.lessondate_before_type_cast
  end
end
