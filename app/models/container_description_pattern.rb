class ContainerDescriptionPattern < ActiveRecord::Base
  belongs_to :container
  belongs_to :language, foreign_key: :lang, primary_key: :code3
  attr_accessible :pattern, :description, :lang, :catalog_tokens
  has_and_belongs_to_many :catalogs, uniq: true, order: 'name'
  validates :pattern, presence: true, uniqueness: {scope: :lang}
  validates :lang, :description, presence: true

  belongs_to :user

  scope :pattern_matches, lambda{ |string|
    where("LENGTH(pattern) = (
             SELECT LENGTH(pattern) AS len FROM container_description_patterns WHERE '#{string}' regexp pattern  ORDER BY len DESC LIMIT 1
           ) AND '#{string}' regexp pattern")
  }

  attr_accessor  :catalog_tokens

  searchable do
    text :pattern, as: :kmedia
    text :description, as: :kmedia

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  def catalog_tokens=(ids)
    self.catalog_ids = ids.split(',')
  end

end
