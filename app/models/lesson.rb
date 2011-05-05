class Lesson < ActiveRecord::Base
  set_primary_key :lessonid
  has_many :lessondesc_patterns, :foreign_key => :lessonid
  has_many :lesson_descriptions, :foreign_key => :lessonid
  belongs_to :lecturer, :foreign_key => :lecturerid
  has_and_belongs_to_many :assets, :join_table => "lessonfiles", :foreign_key => "lessonid",
                          :association_foreign_key => "fileid", :order => "date(updated) DESC, filename ASC"
  has_and_belongs_to_many :catalogs, :join_table => "catnodelessons", :foreign_key => "lessonid",
                          :association_foreign_key => "catalognodeid", :order => "catalognodename"
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  accepts_nested_attributes_for :lesson_descriptions, :reject_if => proc { |attributes| attributes['lessondesc'].blank? }

  attr_accessor :v_lessondate, :catalog_tokens, :rss

#  attr_accessible :lessonid, :lessonname, :created, :updated, :lessondate, :lang, :lecturerid, :secure

  validates :lessonname, :lang, :lesson_descriptions, :catalogs, :presence => true

  before_create :create_timestamps
  before_update :update_timestamps

  scope :ordered, order("date(created) DESC, lessonname ASC")
  scope :need_update, where("date(created) > '2011-03-01' and (lessondate is null or lang is null or lang = '' or (select count(1) from lessondesc where lessondesc.lessonid = lessons.lessonid and lang in('HEB', 'ENG', 'RUS') and length(lessondesc) > 0 ) = 0 or (select count(1) from catnodelessons where catnodelessons.lessonid = lessons.lessonid) = 0)")

  # ThinkingSphinx.search('sefer|zohar', :star => true, :match_mode => :extended, :page => params[:page], :per_page => 10)
  define_index do
    indexes lessonname, :sortable => true
    
    has secure

    set_property :delta => true
  end

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
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

  def rss
    ! (self.catalog_ids & RSS_CATEGORIES.map{|e| e[:id] }).empty?
  end

  def rss=(value)
    if value == "1" && (self.catalog_ids & RSS_CATEGORIES.map{|e| e[:id] }).empty?
      catalogs << Catalog.find(RSS_CATEGORIES[0][:id])
    end
  end

end
