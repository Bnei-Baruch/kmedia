class FileAsset < ActiveRecord::Base
  self.table_name = :files
  self.primary_key = :fileid
  has_and_belongs_to_many :lessons, :join_table => "lessonfiles", :foreign_key => "fileid",
                          :association_foreign_key => "lessonid", :order => "date(lessons.updated) DESC, lessonname ASC"
  has_many :file_asset_descriptions, :foreign_key => :fileid do
    def by_language(code3)
      where(:lang => code3)
    end
  end

  belongs_to :server, :foreign_key => :servername, :primary_key => :servername

  belongs_to :user

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
    text :filename, as: :kmedia

    integer :secure

    string :filelang

    string :filetype

    time :filedate
    time :created
    time :updated

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  before_create :create_timestamps
  before_update :update_timestamps

  scope :latest_updates, -> amount { order('updated DESC').limit(amount).insecure }
  scope :secure, -> level { where('secure <= ?', level) }
  scope :insecure, -> { where('secure = 0') }
  scope :date_within_range, lambda { where('filedate <= ? AND created_at >= ?', Date.today + 100, Date.today - 100) }

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

  def url
    Server::NAME_URL[servername] + '/' + filename
  end

  def download_url
    FileAsset.download_url(servername, filename)
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

  def self.available_languages(file_assets)
    return nil if file_assets.nil?
    field = file_assets[0].respond_to?(:filelang) ? :filelang : :lang
    code3s = file_assets.map(&field).uniq.map { |l| Language::CODE3_LOCALE[l] }
    languages = []
    MAIN_LOCALES.each { |locale|
      languages << code3s.select { |code3| code3 == locale }
    }
    languages << code3s.sort.reject { |code3| MAIN_LOCALES.include?(code3) }
    languages.flatten.compact
  end

  def self.download_url(servername, filename)
    uri = URI(Server::NAME_URL[servername])
    "#{uri.scheme}://#{uri.host}#{uri.port == 80 ? '' : ":#{uri.port}"}/download#{uri.path}/#{filename}"
  end

end
