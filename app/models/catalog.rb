class Catalog < ActiveRecord::Base
  include TheSortableTree::Scopes

  self.table_name  = :catalognode
  self.primary_key = :catalognodeid

  alias_attribute :parent_id, :parentnodeid

  acts_as_tree :foreign_key => 'parentnodeid', :order => 'catalognodename'
  has_and_belongs_to_many :lessons, :join_table    => "catnodelessons", :foreign_key => "catalognodeid",
                          :association_foreign_key => "lessonid", :order => "lessonname ASC, date(updated) DESC"

  has_and_belongs_to_many :lessondesc_patterns, :join_table => "lessondesc_patterns_catalogs", :uniq => true
  has_many :catalog_descriptions, :foreign_key => :catalognodeid, :dependent => :destroy
  accepts_nested_attributes_for :catalog_descriptions, :reject_if => proc { |attributes| attributes['catalognodename'].blank? }

  belongs_to :user

  attr_accessor :has_children

  CLOSED_BY_CENSORSHIP = Catalog.where(catalognodename: 'closed_by_censorship').first

  def to_s
    "#{id} #{catalognodename}"
  end

  searchable do
    text :catalognodename, as: :kmedia
    boolean :secure

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  scope :secure, ->(level) { where('catalognode.secure <= ?', level) }
  scope :insecure, -> { where('catalognode.secure = 0') }
  scope :open_matching_string, ->(string) { where('catalognodename like ? AND open = ?', "%#{string}%", true) }
  scope :visible, -> { where(:visible => true) }
  scope :books, ->(language_code3, secure) { Catalog.secure(secure).joins(:catalog_descriptions).where('books_catalog = true').where('catnodedesc.lang = ?', language_code3) }

  before_create :create_timestamps
  before_update :update_timestamps

  validates :label, :uniqueness => true, :format => { :with => /^[a-zA-Z0-9_-]*$/ }

  class ParentValidator < ActiveModel::Validator
    def validate(catalog)
      catalog.errors[:parentnodeid] << "Catalog can't be an ancestor of himself" if catalog.ancestors.include? catalog
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

# returns children catalogs for the given catalog id
# will return roots catalogs if the provided id is nil or empty
  def self.children_catalogs(id = nil, secure = 0)
    begin
      if id.blank?
        Catalog.secure(secure).visible.roots
      else
        catalog = Catalog.secure(secure).where(catalognodeid: id).first
        catalog.children.secure(secure).visible
      end
    rescue
      nil
    end
  end

  def self.selected_catalogs(language_code3, secure = 0)
    catalogs = Catalog.secure(secure).joins(:catalog_descriptions).where('catnodedesc.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(5)
    ['catalognodeid' => 0, 'catalognodename' => "<strong>#{I18n.t('ui.catalog.all_catalogs')}</strong>"] +
        catalogs.multipluck(:'catalognode.catalognodeid as catalognodeid', :'COALESCE(catnodedesc.catalognodename, catalognode.catalognodename) as catalognodename')
  end

  def self.books_catalog(language_code3, secure = 0)
    books(language_code3, secure).limit(1).multipluck(:'catalognode.catalognodeid as catalognodeid', :'COALESCE(catnodedesc.catalognodename, catalognode.catalognodename) as catalognodename')
  end

  def self.catalog_name(id, language_code3, secure = 0)
    catalog = Catalog.secure(secure).joins(:catalog_descriptions).where(catalognodeid: id).where('catnodedesc.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(1)
    catalog = catalog.multipluck(:'COALESCE(catnodedesc.catalognodename, catalognode.catalognodename) as catalognodename')
    catalog.empty? ? '' : catalog[0]['catalognodename']
  end

  def self.simple_catalog_name(id, language_code3)
    catalog = Catalog.secure(0).joins(:catalog_descriptions).where(catalognodeid: id).where('catnodedesc.lang = ?', language_code3).limit(1)
    catalog = catalog.multipluck(:'COALESCE(catnodedesc.catalognodename, catalognode.catalognodename) as catalognodename')
    catalog.empty? ? '' : catalog[0]['catalognodename']
  end

  def self.selected_catalogs_ar(language_code3, secure = 0)
    Catalog.secure(secure).joins(:catalog_descriptions).where('catnodedesc.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(5)
  end

  def self.count_selected_catalogs
    self.where('selected_catalog > 0').count
  end

  def descendant_catalogs(include_self = true)
    res = include_self ? self : []
    return res if children.empty?
    children.inject(res) do |result, child|
      result << child.descendant_catalogs
      result
    end
  end

  def self.descendant_catalogs_by_catalog_id(catalog_id)
    begin
      Catalog.where(catalognodeid: catalog_id).first.descendant_catalogs
    rescue
      nil
    end
  end

  def self.all_catalogs_with_descriptions(language_code3, secure = 0)
    catalogs = Catalog.secure(secure).joins(:catalog_descriptions)
    .where(
        '`catnodedesc`.lang = ? OR (`catnodedesc`.lang = "ENG" AND NOT EXISTS(SELECT * FROM `catnodedesc` C WHERE `catalognode`.catalognodeid = `C`.catalognodeid AND `C`.lang = ?))',
        language_code3, language_code3)
    .order('catalognodename ASC')
    catalogs.multipluck(:'catalognode.catalognodeid as catalognodeid', :'COALESCE(catnodedesc.catalognodename, catalognode.catalognodename) as catalognodename', :'catalognode.parentnodeid as parentnodeid')
  end

  def self.boost_json(language_code3, secure = 0)
    Catalog.visible.all_catalogs_with_descriptions(language_code3, secure).inject([]) do |boost, node|
      parent        = node['parentnodeid'] || 0
      boost[parent] = [] unless boost[parent]
      boost[parent] << node
      boost
    end
  end

  def self.boost_json_admin
    catalogs = Catalog.order('catalognodename ASC').multipluck(:catalognodeid, :catalognodename, :parentnodeid)
    catalogs.inject([]) do |boost, node|
      parent               = node['parentnodeid'] || 0
      boost[parent]        = [] unless boost[parent]
      object               = Catalog.new(catalognodename: node['catalognodename'], parentnodeid: node['parentnodeid'])
      object.catalognodeid = node['catalognodeid']
      boost[parent] << object
      boost
    end
  end

# Additions to acts_as_tree

# We support moving between _PARENTS ONLY_
  def move_to_child_of(category)
    self.update_attribute(:parent_id, category.id) unless self.parent_id == category.id
  end

  def move_to_right_of(category)
    self.update_attribute(:parent_id, category.parent_id) unless self.parent_id == category.parent_id
    self.update_attribute(:catorder, category.catorder - 1)
  end

  def move_to_left_of(category)
    self.update_attribute(:parent_id, category.parent_id) unless self.parent_id == category.parent_id
    self.update_attribute(:catorder, category.catorder + 1)
  end

# /Additions to acts_as_tree

  def self.move(options)
    target     = options[:target]
    source     = options[:source]
    containers = options[:containers]

    containers.each do |container|
      source.lessons.delete(container)
      target.lessons << container unless target.lessons.pluck(:lessonid).include? container.id
    end
  end

end
