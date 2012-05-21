class Category < ActiveRecord::Base
  belongs_to :dictionary

  has_many :category_descriptions, dependent: :destroy do
    def by_language(code3)
      where(lang: code3)
    end
  end

  validates :suid, presence: true, uniqueness: true, length: 3..20, format: /[\w\.\-]+/

  attr_accessible :suid, :category_descriptions_attributes
  accepts_nested_attributes_for :category_descriptions, allow_destroy: true
  accepts_nested_attributes_for :dictionary
end
