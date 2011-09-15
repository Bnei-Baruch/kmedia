class LessonDescription < ActiveRecord::Base
  set_table_name :lessondesc
  set_primary_key :lessondescid
  belongs_to :lesson, :foreign_key => :lessonid

  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  #define_index do
  #  indexes :lessondesc, :as => :description
  #
  #  set_property :delta => true
  #end
  searchable do
    text :lessondesc, :stored => true
  end

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
  end

  def self.find_by_id(*args, &block)
    self.send(:find_by_lessondescid, *args, &block)
  end

end
