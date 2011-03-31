class Language < ActiveRecord::Base

  has_many :lessons, :foreign_key => :lang, :primary_key => :code3
  has_many :lesson_descriptions, :foreign_key => :lang, :primary_key => :code3

  def to_s
    "#{language} (#{code3})"
  end
end
