class Language < ActiveRecord::Base

  has_many :lessondesc_patterns, :foreign_key => :lang, :primary_key => :code3
  has_many :lessons, :foreign_key => :lang, :primary_key => :code3
  has_many :lesson_descriptions, :foreign_key => :lang, :primary_key => :code3
  has_many :dictionary_descriptions, :foreign_key => :lang, :primary_key => :code3
  has_many :label_descriptions, :foreign_key => :lang, :primary_key => :code3

  # UI languages
  UI_LANGUAGES = ['en', 'he', 'ru', 'es', 'de', 'tr']

  # code3 => locale
  CODE3_LOCALE = Hash.new('en')
  Language.all.map{|l| CODE3_LOCALE[l.code3] = l.locale}
  CODE3_LOCALE.freeze

  # locale => code3
  LOCALE_CODE3 = Hash.new('ENG')
  Language.all.map{|l| LOCALE_CODE3[l.locale] = l.code3}
  LOCALE_CODE3.freeze

  def to_s
    "#{language} (#{code3.upcase})"
  end

  def self.menu_languages(*languages)
    Language.where(:locale => languages).multipluck(:locale, :language)
  end
end
