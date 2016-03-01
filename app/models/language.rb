# == Schema Information
#
# Table name: languages
#
#  id       :integer          not null, primary key
#  locale   :string(255)
#  code3    :string(255)
#  language :string(255)
#

class Language < ActiveRecord::Base

  has_many :container_desc_patterns, foreign_key: :lang, primary_key: :code3
  has_many :containers, foreign_key: :lang, primary_key: :code3
  has_many :container_descriptions, foreign_key: :lang, primary_key: :code3
  has_many :dictionary_descriptions, foreign_key: :lang, primary_key: :code3
  has_many :label_descriptions, foreign_key: :lang, primary_key: :code3

  # UI languages
  UI_LANGUAGES = %w(en he ru es de tr ua)

  # code3 => locale
  CODE3_LOCALE   = Hash.new('en')
  Language.all.map { |l| CODE3_LOCALE[l.code3] = l.locale }
  CODE3_LOCALE.freeze

  # locale => code3
  LOCALE_CODE3 = Hash.new('ENG')
  Language.all.map { |l| LOCALE_CODE3[l.locale] = l.code3 }
  LOCALE_CODE3.freeze

  ALL_LANGUAGES = Language.order('code3').all

  def to_s
    "#{language} (#{code3.upcase})"
  end

  def self.menu_languages(*languages)
    Language.where(locale: UI_LANGUAGES).multipluck(:locale, :language)
  end
end
