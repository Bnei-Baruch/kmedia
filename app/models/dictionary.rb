#
# Dictionary of labels
#
#@author Edo.Shor
#
class Dictionary < ActiveRecord::Base

  # --- Members ---

  # Dictionary's labels
  has_many :labels, dependent: :destroy

  # dictionary topic is translated
  has_many :dictionary_descriptions, dependent: :destroy do
    def by_language(code3)
      where(lang: code3)
    end
  end

  # --- Accessors ---

  attr_accessible :suid, :dictionary_descriptions_attributes
  accepts_nested_attributes_for :dictionary_descriptions, allow_destroy: true

  # --- Validations ---

  # suid stands for Short Unique Identifier
  # Its intended to replace internal DB ids in externally visible urls
  # It must consist of letters, dot and dash only. Length must be between 3 to 20.
  validates :suid, presence: true, uniqueness: true
  validates_length_of :suid, minimum: 3, maximum: 20
  validates_format_of :suid, with: /\A[\w\.\-]+\z/ , message: 'only digits, dot, dash and underscores allowed'

  before_save do |dict|
    dict.suid = dict.suid.downcase
  end

  # --- Public methods ---

  def to_s
    suid
  end

  # fill default values to the fields of this dictionary.
  def fill_defaults
    self.suid = Dictionary.next_suid
    dictionary_descriptions.destroy_all
    Language.all.each do |language|
      dictionary_descriptions.build(lang: language.code3)
    end
  end

  # --- Class methods ---

  # generate next automatic suid
  # TODO: use other mechanism for sequencing ids
  def self.next_suid
    "dict_#{Dictionary.count(conditions: "suid LIKE 'dict_%'") + 1}"
  end

  # select all dictionaries with a suid starting with the prefix
  def self.suid_starts_with(prefix)
    prefix.blank? ? {} :
        Dictionary.select(:suid)
        .where("suid LIKE ?", prefix.downcase + '%')
        .order("suid asc")
  end

end
