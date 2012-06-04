class LessonTranscript < ActiveRecord::Base

  belongs_to :lesson, :foreign_key => :lessonid, :touch => :updated
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  scope :by_lang, lambda {|lang| where(:lang => lang)}
end