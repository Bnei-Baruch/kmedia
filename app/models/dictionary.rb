#
# Dictionary of labels
#
#@author Edo.Shor
#
class Dictionary < ActiveRecord::Base

  # --- Members ---

  # Dictionary's labels
  has_many :labels , dependent: :destroy

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
  validates :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/

  # --- Public methods ---

  def to_s
    suid
  end

  # --- Static methods ---

  # select all dictionaries with a suid starting with the prefix
  def self.suid_starts_with(prefix)
    Dictionary.select(:suid).where("suid LIKE ?", prefix + '%').order("suid asc")
  end

  # generate next automatic suid
  def self.next_suid
    'dict_' + (Dictionary.count(conditions: "suid LIKE 'dict_%'") + 1).to_s
  end

end
