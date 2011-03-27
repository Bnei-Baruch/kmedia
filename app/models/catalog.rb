class Catalog < ActiveRecord::Base
  set_table_name :catalognode
  set_primary_key :catalognodeid
  acts_as_tree :foreign_key => 'parentnodeid', :order => 'catorder'
  has_and_belongs_to_many :lessons, :join_table => "catnodelessons", :foreign_key => "catalognodeid",
                          :association_foreign_key => "lessonid", :order => "lessonname ASC, date(updated) DESC"

  
  def before_create
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def before_update
    write_attribute :updated, Time.now
  end
  
end
