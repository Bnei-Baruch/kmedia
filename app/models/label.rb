class Label < ActiveRecord::Base
  belongs_to :dictionary

  has_many :label_descriptions, dependent: :destroy do
    def by_language(code3)
      where(lang: code3)
    end
  end

  validates :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/

  attr_accessible :suid, :label_descriptions_attributes
  accepts_nested_attributes_for :label_descriptions, allow_destroy: true
  accepts_nested_attributes_for :dictionary

  def display_name
    label_descriptions.where(lang: ('HEB')).first.text + " [ #{suid} ]"
    end
end
