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

  has_and_belongs_to_many :lessons, uniq: true, join_table: 'lessons_labels'

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

  before_save do |lbl|
    lbl.suid = lbl.suid.downcase
  end

  # --- Public methods ---

  def to_s
    suid
  end

  def display_name
    label_descriptions.select {|d| d.lang == 'ENG'}[0].text
  end

  # select all labels with a suid starting with the prefix
  def self.suid_starts_with(prefix)
    Label.select(:suid).where("suid LIKE ?", prefix.downcase + '%').order("suid asc") unless prefix.blank?
  end

  # generate next automatic suid
  def self.next_suid
    "lbl_#{Label.count(conditions: "suid LIKE 'lbl_%'") + 1}"
  end

end
