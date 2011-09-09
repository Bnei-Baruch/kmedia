class Asset < ActiveRecord::Base
  set_table_name :files
  set_primary_key :fileid
  has_and_belongs_to_many :lessons, :join_table => "lessonfiles", :foreign_key => "fileid",
                          :association_foreign_key => "lessonid", :order => "date(updated) DESC, lessonname ASC"
  has_many :asset_descriptions, :foreign_key => :fileid

  belongs_to :server, :foreign_key => :servername, :primary_key => :servername

  define_index do
    indexes filename, :sortable => true

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

  def url
    server.httpurl + '/' + filename
  end

end
