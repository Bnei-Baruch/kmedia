class Lesson < ActiveRecord::Base
  set_primary_key :lessonid
  has_many :lesson_descriptions, :foreign_key => :lessonid
  belongs_to :lecturer, :foreign_key => :lecturerid
  has_and_belongs_to_many :assets, :join_table => "lessonfiles", :foreign_key => "lessonid",
                          :association_foreign_key => "fileid", :order => "date(updated) DESC, filename ASC"
  has_and_belongs_to_many :catalogs, :join_table => "catnodelessons", :foreign_key => "lessonid",
                          :association_foreign_key => "catalognodeid", :order => "catalognodename"

  attr_accessor :v_lessondate, :catalog_tokens

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

  # Virtual column to emulate varchar lessondate in db
  columns_hash["v_lessondate"] = ActiveRecord::ConnectionAdapters::Column.new("v_lessondate", nil, "date")

  def v_lessondate
    Date.strptime(lessondate, '%Y-%m-%d') rescue nil
  end

  def v_lessondate=(my_date)
    self.lessondate = my_date.to_s
  end

  def catalog_tokens=(ids)
    self.catalog_ids = ids.split(',')
  end
end
