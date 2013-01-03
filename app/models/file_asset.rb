class FileAsset < ActiveRecord::Base
  self.table_name = :files
  self.primary_key = :fileid
  has_and_belongs_to_many :lessons, :join_table => "lessonfiles", :foreign_key => "fileid",
                          :association_foreign_key => "lessonid", :order => "date(updated) DESC, lessonname ASC"
  has_many :file_asset_descriptions, :foreign_key => :fileid do
    def by_language(code3)
      where(:lang => code3)
    end
  end

  belongs_to :server, :foreign_key => :servername, :primary_key => :servername

  attr_accessor :v_filedate
  # Virtual column to emulate varchar filedate in db
  columns_hash["v_filedate"] = ActiveRecord::ConnectionAdapters::Column.new("v_filedate", nil, "date")

  def v_filedate
    Date.strptime(filedate.to_s, '%Y-%m-%d') rescue nil
  end

  def v_filedate=(my_date)
    self.filedate = my_date.to_s
  end

  searchable do
    text :filename
  end

  before_create :create_timestamps
  before_update :update_timestamps

  scope :latest_updates, -> amount {order('updated DESC').limit(amount) }

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

  def download_url
    uri = URI(server.httpurl)
    "#{uri.scheme}://#{uri.host}#{uri.port == 80 ? '' : ":#{uri.port}"}/download#{uri.path}/#{filename}"
  end

  def typename
    FileType.ext_to_type(filetype)
  end

  def icon
    FileType.ext_to_icon(filetype)
  end

  def <=>(other)
    self.filetype <=> other.filetype
  end
end
