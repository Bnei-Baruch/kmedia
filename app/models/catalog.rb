class Catalog < ActiveRecord::Base
  set_table_name :catalognode
  set_primary_key :catalognodeid
  acts_as_tree :foreign_key => 'parentnodeid', :order => 'catorder'
  has_and_belongs_to_many :lessons, :join_table => "catnodelessons", :foreign_key => "catalognodeid",
                          :association_foreign_key => "lessonid", :order => "lessonname ASC, date(updated) DESC"

  has_many :catalog_descriptions, :foreign_key => :catalognodeid
  accepts_nested_attributes_for :catalog_descriptions, :reject_if => proc { |attributes| attributes['catalogdesc'].blank? }

  define_index do
    indexes catalognodename

    has secure

    set_property :delta => true
  end

  before_create :create_timestamps
  before_update :update_timestamps

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

end
