class LessondescPattern < ActiveRecord::Base
  belongs_to :lesson, :foreign_key => :lessonid
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3
  attr_accessible :pattern, :description, :lang, :catalog_tokens
  has_and_belongs_to_many :catalogs, :join_table => "lessondesc_patterns_catalogs", :uniq => true, :order => "catalognodename"
  validates :pattern, :presence => true, :uniqueness => {:scope => :lang}
  validates :lang, :description, :presence => true

  scope :pattern_matches, lambda{ |string|
    where("LENGTH(pattern) = (
             SELECT LENGTH(pattern) AS len FROM `lessondesc_patterns` WHERE '#{string}' regexp pattern  ORDER BY len DESC LIMIT 1
           ) AND '#{string}' regexp pattern")
  }

  attr_accessor  :catalog_tokens

  searchable do
    text :pattern, :stored => true
    text :description, :stored => true
  end

  def catalog_tokens=(ids)
    self.catalog_ids = ids.split(',')
  end

end
