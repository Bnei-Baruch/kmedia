class Catalog < ActiveRecord::Base
  include TheSortableTree::Scopes

  acts_as_tree foreign_key: 'parent_id', order: 'name'
  has_and_belongs_to_many :containers, join_table: 'catalogs_containers', order: 'lessonname ASC, DATE(updated) DESC'
  has_and_belongs_to_many :container_desc_patterns, join_table: 'container_descriptions_patterns_catalogs', uniq: true
  has_many :catalog_descriptions, dependent: :destroy
  accepts_nested_attributes_for :catalog_descriptions, reject_if: proc { |attributes| attributes['name'].blank? }

  belongs_to :user

  attr_accessor :has_children

  CLOSED_BY_CENSORSHIP = Catalog.where(name: 'closed_by_censorship').first

  def to_s
    "#{id} #{name}"
  end

  searchable do
    text :name, as: :kmedia
    boolean :secure

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  scope :secure, ->(level) { where('secure <= ?', level) }
  scope :insecure, -> { where('secure = 0') }
  scope :open_matching_string, ->(string) { where('name like ? AND open = ?', "%#{string}%", true) }
  scope :visible, -> { where(:visible => true) }
  scope :books, ->(language_code3, secure) { Catalog.secure(secure).joins(:catalog_descriptions).where('books_catalog = true').where('catalog_descriptions.lang = ?', language_code3) }

  validates :label, uniqueness: true, format: { with: /^[a-zA-Z0-9_-]*$/ }

  class ParentValidator < ActiveModel::Validator
    def validate(catalog)
      catalog.errors[:parent_id] << "Catalog can't be an ancestor of himself" if catalog.ancestors.include? catalog
    end
  end

  validates_with ParentValidator

# returns children catalogs for the given catalog id
# will return roots catalogs if the provided id is nil or empty
  def self.children_catalogs(id = nil, secure = 0)
    begin
      if id.blank?
        Catalog.secure(secure).visible.roots
      else
        catalog = Catalog.secure(secure).where(id: id).first
        catalog.children.secure(secure).visible
      end
    rescue
      nil
    end
  end

  def self.selected_catalogs(language_code3, secure = 0)
    catalogs = Catalog.secure(secure).joins(:catalog_descriptions).where('catalog_descriptions.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(5)
    ['id' => 0, 'name' => "<strong>#{I18n.t('ui.catalog.all_catalogs')}</strong>"] +
        catalogs.multipluck(:'catalogs.id as id', :'COALESCE(catalog_descriptions.name, catalogs.name) as name')
  end

  def self.books_catalog(language_code3, secure = 0)
    books(language_code3, secure).limit(1).multipluck(:'catalogs.id as id', :'COALESCE(catalog_descriptions.name, catalogs.name) as name')
  end

  def self.catalog_name(id, language_code3, secure = 0)
    catalog = Catalog.secure(secure).joins(:catalog_descriptions).where(id: id).where('catalog_descriptions.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(1)
    catalog = catalog.multipluck(:'COALESCE(catalog_descriptions.name, catalogs.name) as name')
    catalog.empty? ? '' : catalog[0]['name']
  end

  def self.simple_catalog_name(id, language_code3)
    catalog = Catalog.secure(0).joins(:catalog_descriptions).where(id: id).where('catalog_descriptions.lang = ?', language_code3).limit(1)
    catalog = catalog.multipluck(:'COALESCE(catalog_descriptions.name, catalogs.name) as name')
    catalog.empty? ? '' : catalog[0]['name']
  end

  def self.selected_catalogs_ar(language_code3, secure = 0)
    Catalog.secure(secure).joins(:catalog_descriptions).where('catalog_descriptions.lang = ?', language_code3).where('selected_catalog > 0').order('selected_catalog DESC').limit(5)
  end

  def self.count_selected_catalogs
    self.where('selected_catalog > 0').count
  end

  def descendant_catalogs(include_self = true)
    res = include_self ? self : []
    return res if children.empty?
    children.inject(res) do |result, child|
      result << child.descendant_catalogs
    end
  end

  def self.descendant_catalogs_by_catalog_id(catalog_id)
    begin
      Catalog.where(id: catalog_id).first.descendant_catalogs
    rescue
      nil
    end
  end

  def self.all_catalogs_with_descriptions(language_code3, secure = 0)
    catalogs = Catalog.secure(secure).joins(:catalog_descriptions)
    .where(
        'catalog_descriptions.lang = ? OR (catalog_descriptions.lang = \'ENG\' AND NOT EXISTS(SELECT * FROM catalog_descriptions C WHERE catalogs.id = C.catalog_id AND C.lang = ?))',
        language_code3, language_code3)
    .order('name ASC')
    catalogs.multipluck(:'catalogs.id as id', :'COALESCE(catalog_descriptions.name, catalogs.name) as name', :'catalogs.parent_id as parent_id')
  end

  def self.boost_json(language_code3, secure = 0)
    Catalog.visible.all_catalogs_with_descriptions(language_code3, secure).inject([]) do |boost, node|
      parent        = node['parent_id'] || 0
      boost[parent] = [] unless boost[parent]
      boost[parent] << node
      boost
    end
  end

  def self.boost_json_admin
    catalogs = Catalog.order('name ASC').multipluck(:id, :name, :parent_id)
    catalogs.inject([]) do |boost, node|
      parent               = node['parent_id'] || 0
      boost[parent]        = [] unless boost[parent]
      object               = Catalog.new(name: node['name'], id: node['id'])
      object.id = node['id']
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
      target.lessons << container unless target.lessons.pluck(:id).include? container.id
    end
  end

end
