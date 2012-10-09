class Catalog < ActiveRecord::Base
  self.table_name = :catalognode
  self.primary_key = :catalognodeid
  acts_as_tree :foreign_key => 'parentnodeid', :order => 'catorder'
  has_and_belongs_to_many :lessons, :join_table => "catnodelessons", :foreign_key => "catalognodeid",
                          :association_foreign_key => "lessonid", :order => "lessonname ASC, date(updated) DESC"

  has_and_belongs_to_many :lessondesc_patterns, :join_table => "lessondesc_patterns_catalogs", :uniq => true
  has_many :catalog_descriptions, :foreign_key => :catalognodeid, :dependent => :destroy
  accepts_nested_attributes_for :catalog_descriptions, :reject_if => proc { |attributes| attributes['catalognodename'].blank? }

  attr_accessor :has_children

  searchable do
    text :catalognodename
    boolean :secure
  end

  scope :secure, lambda { |level| where("secure <= ?", level) }
  scope :open_matching_string, lambda { |string| where("catalognodename like ? AND open = ?", "%#{string}%", true )}

  before_create :create_timestamps
  before_update :update_timestamps

  class ParentValidator < ActiveModel::Validator
    def validate(catalog)
      catalog.errors[:parentnodeid]<< "Catalog can't be a parent of himself" if catalog.parentnodeid = catalog.catalognodeid
    end
  end

  validates_with ParentValidator

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

end
