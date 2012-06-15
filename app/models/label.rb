#
# Labels which allow to tag any content in the system. I18n
#
#@author Edo.Shor
#
class Label < ActiveRecord::Base

  # --- Members ---

  # Label's dictionary
  belongs_to :dictionary

  # label text is translated
  has_many :label_descriptions, dependent: :destroy do
    def by_language(code3)
      where(lang: code3)
    end
  end

  # --- Accessors ---

  attr_accessible :suid, :label_descriptions_attributes
  accepts_nested_attributes_for :label_descriptions, allow_destroy: true
  accepts_nested_attributes_for :dictionary

  # --- Validations ---

  # make sure we have a dictionary
  validates :dictionary, presence: true

  # suid stands for Short Unique Identifier
  # Its intended to replace internal DB ids in externally visible urls
  # It must consist of letters, dot and dash only. Length must be between 3 to 20.
  validates :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/

  # --- Public methods ---

  def to_s
    label_descriptions.where(lang: ('HEB')).first.text + " [ #{suid} ]"
    end
end
