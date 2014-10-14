# == Schema Information
#
# Table name: container_transcripts
#
#  id           :integer          not null, primary key
#  container_id :integer
#  toc          :string(255)
#  transcript   :text
#  lang         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ContainerTranscript < ActiveRecord::Base

  belongs_to :container, touch: :updated_at
  belongs_to :language, foreign_key: :lang, primary_key: :code3

  scope :by_lang, lambda {|lang| where(:lang => lang)}
end
