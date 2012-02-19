class LessonDescription < ActiveRecord::Base
  self.table_name = :lessondesc
  self.primary_key = :lessondescid
  belongs_to :lesson, :foreign_key => :lessonid, :touch => :updated

  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  searchable do
    text :lessondesc, :stored => true
    text :descr, :stored => true
  end

  scope :by_lang, lambda {|lang| where(:lang => lang)}

  before_create :create_timestamps
  before_update :update_timestamps
  before_save :flattern_desc

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

  def flattern_desc
    write_attribute :lessondesc_flat, self.lessondesc.downcase if self.lessondesc
    write_attribute :descr_flat, self.descr.downcase if self.descr
  end

  def self.find_by_id(*args, &block)
    self.send(:find_by_lessondescid, *args, &block)
  end

end
