class Language < ActiveRecord::Base

  has_many :lessondesc_patterns, :foreign_key => :lang, :primary_key => :code3
  has_many :lessons, :foreign_key => :lang, :primary_key => :code3
  has_many :lesson_descriptions, :foreign_key => :lang, :primary_key => :code3
  has_many :dictionary_descriptions, :foreign_key => :lang, :primary_key => :code3
  has_many :label_descriptions, :foreign_key => :lang, :primary_key => :code3

  # code3 => locale
  CODE3_LOCALE = Hash[Language.all.map{|l| [l.code3, l.locale]}].freeze
  # locale => code3
  LOCALE_CODE3 = Hash[Language.all.map{|l| [l.locale, l.code3]}].freeze

  def to_s
    "#{language} (#{code3.upcase})"
  end

end
