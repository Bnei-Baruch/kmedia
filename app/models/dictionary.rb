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
    dictionary_descriptions.where(lang: ('HEB')).first.topic + " [ #{suid} ]"
  end
end
