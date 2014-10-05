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

  has_and_belongs_to_many :containers, uniq: true

  # --- Accessors ---

  attr_accessible :suid, :dictionary_id, :label_descriptions_attributes
  accepts_nested_attributes_for :label_descriptions, allow_destroy: true

  # --- Validations ---

  # make sure we have a dictionary
  validates :dictionary, presence: true

  # suid stands for Short Unique Identifier
  # Its intended to replace internal DB ids in externally visible urls
  # It must consist of letters, dot and dash only. Length must be between 3 to 20.
  validates :suid, presence: true, uniqueness: true
  validates_length_of :suid, minimum: 3, maximum: 20
  validates_format_of :suid, with: /\A[\w\.\-]+\z/ , message: 'only digits, dot, dash and underscores allowed'

  before_save do |lbl|
    lbl.suid = lbl.suid.downcase
  end

  # --- Public methods ---

  def to_s
    suid
  end

  def display_name
    label_descriptions.select.by_language('ENG')[0].text
  end

  # fill default values to this label
  def fill_defaults(dictionary_id)
    self.suid= Label.next_suid
    self.dictionary = Dictionary.find(dictionary_id)
    label_descriptions.destroy_all
    Language.all.each do |language|
      label_descriptions.build(lang: language.code3)
    end
  end

  # --- Class methods ---

  # generate next automatic suid
  # TODO: use other mechanism for sequencing ids
  def self.next_suid
    "lbl_#{Label.count(conditions: "suid LIKE 'lbl_%'") + 1}"
  end

  # select all labels with a suid starting with the prefix
  def self.suid_starts_with(prefix)
    prefix.blank? ? {} :
        Label.select(:suid)
        .where("suid LIKE ?", prefix.downcase + '%')
        .order("suid asc")
  end

end
