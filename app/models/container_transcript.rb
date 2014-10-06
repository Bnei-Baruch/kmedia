class ContainerTranscript < ActiveRecord::Base

  belongs_to :container, touch: :updated_at
  belongs_to :language, foreign_key: :lang, primary_key: :code3

  scope :by_lang, lambda {|lang| where(:lang => lang)}
end
