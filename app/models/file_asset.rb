class FileAsset < ActiveRecord::Base
  has_and_belongs_to_many :containers, order: 'containers.updated_at DESC, name ASC'
  has_many :file_asset_descriptions, foreign_key: :id do
    def by_language(code3)
      where(lang: code3)
    end
  end

  belongs_to :server, foreign_key: :servername, primary_key: :servername

  belongs_to :user

  attr_accessible :asset_type, :name, :lang, :date, :size, :playtime_secs, :lastuser, :servername, :secure

  attr_accessor :v_filedate
  # Virtual column to emulate varchar filedate in db
  columns_hash["v_filedate"] = ActiveRecord::ConnectionAdapters::Column.new("v_filedate", nil, "date")

  def v_filedate
    Date.strptime(date.to_s, '%Y-%m-%d') rescue nil
  end

  def v_filedate=(my_date)
    self.date = my_date.to_s
  end

  searchable do
    text :name, as: :kmedia

    integer :secure

    string :lang

    string :asset_type

    time :date
    time :created_at
    time :updated_at

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  scope :latest_updates, -> amount { order('updated_at DESC').limit(amount).insecure }
  scope :secure, -> level { where('secure <= ?', level) }
  scope :insecure, -> { where('secure = 0') }
  scope :date_within_range, lambda { where('date <= ? AND created_at >= ?', Date.today + 100, Date.today - 100) }

  def url
    Server::NAME_URL[servername] + '/' + name
  end

  def download_url
    FileAsset.download_url(servername, name)
  end

  def typename
    FileType.ext_to_type(asset_type)
  end

  def icon
    FileType.ext_to_icon(asset_type)
  end

  def <=>(other)
    self.asset_type <=> other.asset_type
  end

  def update_playtime
    playtime_secs = begin
      uri  = URI(server.httpurl)
      path = "#{uri.scheme}://#{uri.host}#{uri.port == 80 ? '' : ":#{uri.port}"}/download#{uri.path}/#{name}"

      extension = File.extname(name) rescue raise("Wrong :file value (Unable to detect file extension): #{name}")
      extension = extension[1..10] # Skip '.' in the beginning of extension, i.e. .mp3 => mp3

      if extension == 'mp3'
        m = Mp3Info.open(open(path))
        m.length.round(0)
      elsif extension == 'mp4'
        info = MP4Info.open(open(path))
        info.SECS
      elsif extension == 'wma' || extension == 'wmv' || extension == 'asf'
        f = WmaInfo.new(open(path))
        f.info['playtime_seconds']
      else
        0
      end
    rescue Exception => e
      logger = Container.my_logger
      logger.info("update_playtime; UPS(#{path}) #{e.message}")
      0
    end

    if playtime_secs > 0
      update_attribute(:playtime_secs, playtime_secs)

      containers.each do |container|
        if container.playtime_secs.to_i <= 0
          container.update_attribute(:playtime_secs, playtime_secs)
        end
      end
    end
  end

  def self.available_languages(file_assets)
    return nil if file_assets.nil?
    code3s    = file_assets.map(&:lang).uniq.map { |l| Language::CODE3_LOCALE[l] }
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

# Select updated files and their lesson IDs
  def FileAsset.get_updated_files(days)
    FileAsset.
        select("CONCAT( servers.httpurl, '/', file_assets.name ) AS link, file_assets.lang AS flang, file_assets.asset_type AS ftype, file_assets.size AS fsize, file_assets.updated_at AS updated_at, containers.id AS id").
        where(:'file_assets.updated_at' => days.days.ago.to_s(:db)..0.days.ago.to_s(:db)).
        joins(:server, :containers).
        order(:id, :ftype).
        all.group_by { |x| x['id'] }
  end

end
