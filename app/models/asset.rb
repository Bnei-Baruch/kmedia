class Asset < ActiveRecord::Base
  set_table_name :files
  set_primary_key :fileid
  has_and_belongs_to_many :lessons, :join_table => "lessonfiles", :foreign_key => "fileid",
                          :association_foreign_key => "lessonid", :order => "date(updated) DESC, lessonname ASC"
  has_many :asset_descriptions, :foreign_key => :fileid
#  attr_accessible :fileid, :filename, :created, :updated, :filedate, :filetype, :filelang, :filesize, :servername, :filestatus, :lastuser, :fileclicks

  def before_create
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def before_update
    write_attribute :updated, Time.now
  end
  
end
