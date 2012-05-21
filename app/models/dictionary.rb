class Dictionary < ActiveRecord::Base
  has_many :dictionary_descriptions, dependent: :destroy do
    def by_language(code3)
      where(lang: code3)
    end
  end

  has_many :labels , dependent: :destroy

  validates :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/

  attr_accessible :suid, :dictionary_descriptions_attributes, :labels_attributes

  accepts_nested_attributes_for :dictionary_descriptions, allow_destroy: true
  accepts_nested_attributes_for :labels, allow_destroy: true
end
