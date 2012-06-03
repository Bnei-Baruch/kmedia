class LessonTranscript < ActiveRecord::Base

  belongs_to :lesson, :foreign_key => :lessonid, :touch => :updated
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  scope :by_lang, lambda {|lang| where(:lang => lang)}

  before_create :create_timestamps
  before_update :update_timestamps

  def create_timestamps
    write_attribute :created_at, Time.now
    write_attribute :updated_at, Time.now
  end

  def update_timestamps
    write_attribute :updated_at, Time.now
  end
end