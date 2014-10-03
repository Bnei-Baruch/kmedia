class Container < ActiveRecord::Base
  has_many :container_descriptions_patterns
  has_many :container_descriptions do
    def by_language(code3)
      where(lang: code3)
    end
  end
  has_many :container_transcripts do
    def by_language(code3)
      where(lang: code3)
    end
  end
  belongs_to :lecturer
  belongs_to :content_type
  belongs_to :virtual_lesson
  has_and_belongs_to_many :file_assets, order: 'updated_at DESC, name ASC'
  has_and_belongs_to_many :catalogs, order: 'name'
  belongs_to :language, foreign_key: :lang, primary_key: :code3

  has_and_belongs_to_many :labels, uniq: true
  belongs_to :user

  before_destroy do |container|
    container.file_assets.each do |a|
      # Do not destroy files that belongs to more than one container
      a.delete if a.lesson_ids.length == 1
    end

    # remove empty virtual lessons
    virtual_lesson = container.virtual_lesson
    virtual_lesson.destroy if virtual_lesson && virtual_lesson.containers.count > 1
  end

  LESSON_CONTENT_TYPE_ID = ContentType::CONTENT_TYPE_ID['lesson']
  LESSON_PART            = Catalog.where(name: 'lessons-part').first
  VIDEO_CATALOG          = Catalog.where(name: 'Video').first

  accepts_nested_attributes_for :container_descriptions, :container_transcripts

  attr_accessor :v_containerdate, :catalog_tokens, :rss, :label_tokens
  attr_accessor :container_ids

  validates :name, :lang, :catalogs, :content_type_id, presence: true

  class OpenCatalogsValidator < ActiveModel::Validator
    def validate(record)
      record.catalogs.each do |catalog|
        record.errors[:base]<< "Catalog is closed" unless catalog.open
      end
    end
  end

  validates_with OpenCatalogsValidator

  class NonemptyValidator < ActiveModel::Validator
    #, :fields => [:lesson_descriptions]
    def validate(record)
      # At least ENG, RUS and HEB must be non-empty
      lds = {}
      record.container_descriptions.map { |x| lds[x.lang] = x.container_descriptions }
      if lds['ENG'].blank? || lds['RUS'].blank? || lds['HEB'].blank?
        record.errors[:base] << "Empty Basic Description(s)"
      end
    end
  end
  validates_with NonemptyValidator

  scope :ordered, order("DATE(created_at) DESC, name ASC")
  scope :need_update, where(<<-NEED_UPDATE
    DATE(created_at) > '2011-03-01' AND
    (
      filmdate IS NULL OR
      lang IS NULL OR
      lang = '' OR
      (SELECT count(1) FROM container_descriptions WHERE container_descriptions.container_id = containers.id AND lang IN('HEB', 'ENG', 'RUS') AND length(container_descriptions) > 0 ) = 0 OR
      (SELECT count(1) FROM catalogs_containers WHERE catalogs_containers.container_id = containers.id) = 0 OR
      auto_parsed = TRUE
    )
  NEED_UPDATE
  )
  scope :for_censorship, -> { where(for_censorship: true) }
  scope :not_for_censorship, -> { where(for_censorship: false) }
  scope :secure_changed, -> { where(secure_changed: true) }
  scope :no_files, -> { where('(SELECT count(1) FROM file_assets_containers WHERE container_id = containers.id) = 0') }

  scope :lost, -> { where(<<-LOST
      id not in
        (SELECT distinct id from catalogs_containers INNER JOIN catalogs ON catalogs.id = catalogs_containers.catalog_id WHERE
        (name NOT IN ('Containers','lesson_first-part','lesson_second-part','lesson_third-part','lesson_fourth-part',
        'lesson_fifth-part','RSS_update','Video','Audio')))
  LOST
  ) }

  scope :security, -> sec { where(secure: sec) }
  scope :non_secure, -> { where(secure: 0) }

  def self.last_lectures_programs(container_date = Date.today, language = 'ENG')
    joins(:file_assets).where('file_assets.lang' => language).where(date: container_date).where(content_type_id: [ContentType::CONTENT_TYPE_ID['lecture'], ContentType::CONTENT_TYPE_ID['program']])
  end


  def self.available_languages(containers)
    return nil if containers.nil?
    FileAsset.available_languages containers.map(&:file_assets).flatten.sort.uniq.compact
  end

  def self.get_all_descriptions(containers)
    Container.where(id: containers).includes(:container_descriptions).all.inject({}) do |all, container|
      all[container.id] = container.container_descriptions
      all
    end
  end

  def to_label
    name
  end

  searchable(include: [:container_descriptions, :file_assets, :catalogs]) do
    text :name, as: :kmedia

    text :description, as: :kmedia do
      container_descriptions.pluck('CONCAT(COALESCE(container_desc,\'\'), COALESCE(descr,\'\'))').join(' ').gsub!(/[^[:print:]]/i, '')
    end

    integer :secure
    integer :content_type_id

    string :file_language_ids, multiple: true do
      file_assets.pluck('lang').sort.uniq
    end

    string :media_type_ids, multiple: true do
      file_assets.pluck('asset_type').sort.uniq
    end

    integer :catalog_ids, multiple: true

    time :filmdate
    time :created_at
    time :updated_at

    boolean :for_censorship
    boolean :closed_by_censor
  end

  # Virtual column to emulate varchar containerdate in db
  columns_hash["v_containerdate"] = ActiveRecord::ConnectionAdapters::Column.new("v_containerdate", nil, "date")

  def v_containerdate
    Date.strptime(containerdate.to_s, '%Y-%m-%d') rescue nil
  end

  def v_containerdate=(my_date)
    self.date = my_date.to_s
  end

  def catalog_tokens=(ids)
    self.catalog_ids = ids.split(',')
  end

  def label_tokens=(ids)
    self.label_ids = ids.split(',')
  end

  def rss
    !(self.catalog_ids & RSS_CATEGORIES.map { |e| e[:id] }).empty?
  end

  def rss=(value)
    if value == "1" && (self.catalog_ids & RSS_CATEGORIES.map { |e| e[:id] }).empty?
      catalogs << Catalog.find(RSS_CATEGORIES[0][:id])
    end
  end

  def self.get_appropriate_containers(filter, security)
    case filter
    when 'all'
      Container
    when 'secure_changed'
      Container.secure_changed
    when 'no_files'
      Container.no_files
    when 'lost'
      Container.lost
    when 'by_security'
      Container.security(security)
    else
      Container.need_update
    end.where(for_censorship: false)
  end

  def self.get_container_title(id, language)
    container = Container.find(id) rescue { name: '----------', date: '1970-01-01', created_at: '1970-01-01' }
    descr          = container.container_descriptions.by_language(language).first.try(:container_descriptions)
    descr          = container.container_descriptions.by_language('ENG').first.try(:container_descriptions) if descr.blank?
    container.name = descr if descr

    if descr && (container.catalogs.map(&:id) & [3606, 3661, 3662]).empty?
      nil
    else
      container.name +
          (container.date.to_s == '0000-00-00' ? '' : " (#{container.date})")
    end
  end

  # Register file(s) into a container.
  #
  # Both file(s) and container may exist and will be updated.
  # The file(s) will be assigned to container.
  # Non-existing file descriptions, according fo file extension + _96k,
  # will be updated - filedesc (fileid,lang,filedesc)
  #
  # The following tables/fields will be updated automatically (for a new container or file only):
  # container:  date, language, lecturer (if rav), container type, descriptions
  #
  # @param container - name of container (directory)
  # @param dry_run - do not create container or file (default - false)
  # @param files - array of name-server-size-time objects
  def self.add_update(container_name, files, dry_run = false)
    raise 'Container\'s name cannot be blank' if container_name.blank?
    my_logger.info("###############################################################")
    my_logger.info("Container arrived #{container_name} dry_run= #{dry_run}")

    # Create/update container
    container = Container.where(name: container_name).first_or_initialize do |c|
      # Update fields for new container only
      return unless c.new_record?

      # Try to update auto-fill-able fields
      c.catalogs << VIDEO_CATALOG unless c.catalogs.include? VIDEO_CATALOG
      my_logger.info("Catalogs after video assignment: #{get_catalogs_names(c.catalogs)}")

      sp = ::StringParser.new container_name
      c.filmdate = Date.new(sp.date[0], sp.date[1], sp.date[2]).to_s rescue Time.now.to_date
      c.lang = sp.language.upcase rescue 'ENG'
      c.lecturer_id = Lecturer.rav.first.id if sp.lecturer_rav?
      sp.descriptions.includes(:catalogs).each { |pattern|
        my_logger.info c.inspect
        my_logger.info c.container_descriptions.inspect
        c.container_descriptions.build(lang: pattern.lang, container_desc: pattern.description)
        pattern.catalogs.each { |pc|
          c.catalogs << pc unless c.catalogs.include? pc
        }
      }
      my_logger.info("Catalogs after assignment from pattern: #{get_catalogs_names(c.catalogs)}")
      c.content_type_id = sp.content_type.id
      c.secure          = sp.content_security_level
      c.auto_parsed     = true

      lang_codes = c.container_descriptions.map(&:lang)
      Language::ALL_LANGUAGES.each { |l|
        c.container_descriptions.build(lang: l.code3) unless lang_codes.include?(l.code3)
      }
      c.create_virtual_lesson unless dry_run
    end
    my_logger.info("Catalogs before save: #{get_catalogs_names(container.catalogs)}")

    if !dry_run && container.position.blank?
      container.position = (container.virtual_lesson.lessons.count + 1) rescue 0
    end

    container.save!(validate: false) unless dry_run
    my_logger.info("Container saved")

    (files || []).each do |file|
      name   = file['file']
      server = file['server'] || DEFAULT_FILE_SERVER
      size   = file['size'] || 0
      datetime = file['time'] ? Time.at(file['time']) : Time.now rescue raise("Wrong :time value: #{file['time']}")

      extension = File.extname(name) rescue raise("Wrong :file value (Unable to detect file extension): #{name}")
      extension = extension[1..-1] # Skip '.' in the beginning of extension, i.e. .mp3 => mp3

      file_asset = FileAsset.where(name: name).first

      playtime_secs = file['playtime_secs'].to_i

      my_logger.info("File name=#{name} server=#{server} size=#{size} datetime=#{datetime} extension=#{extension} playtime_secs=#{playtime_secs}")

      if file_asset.nil?
        # New file
        name =~ /^([^_]+)_/
        lang = Language.find_by_code3($1.upcase).code3 rescue 'ENG'
        sp     = ::StringParser.new name
        secure = sp.content_security_level

        file_asset = FileAsset.new(name:          name, lang: lang, asset_type: extension, date: datetime, size: size,
                                   playtime_secs: playtime_secs, lastuser: 'system', servername: server, secure: secure)
        my_logger.info("New file lang=#{lang} secure=#{secure}")
      elsif !dry_run
        my_logger.info("Existing file, just update")
        file_asset.update_attributes(date: datetime, size: size, playtime_secs: playtime_secs, lastuser: 'system', servername: server)
      end

      if !dry_run && !container.file_asset_ids.include?(file_asset.id)
        my_logger.info("Adding to container...")
        container.file_assets << file_asset
        container.update_attribute(:playtime_secs, file_asset.playtime_secs) if container.playtime_secs.to_i <= 0 && file_asset.playtime_secs > 0
        raise "Unable to save/update file #{name}" unless file_asset.save
        my_logger.info("... added")
      end

      # Update file description for non-existing UI languages
      file_desc = case
                  when name =~ /_draw_/
                    extension.downcase == 'zip' ? '<b>draw ZIP</b>' : '<b>draw</b>'
                  when name =~ /_scan_/
                    extension.downcase == 'zip' ? '<b>scan ZIP</b>' : '<b>scan</b>'
                  else
                    case extension.downcase.downcase
                    when 'zip'
                      '<b>ZIP FILE</b>'
                    when 'pdf'
                      '<b>pdf</b>'
                    when 'flv'
                      '<b>flv</b>'
                    when 'mp4'
                      '<b>mp4</b>'
                    else
                      '2/2 <b>original 96K</b>' if name =~ /_96k/
                    end
                  end
      my_logger.info("File description file_desc=#{file_desc}")

      unless file_desc.blank?
        ui_langs = Language.all.map(&:code3) - container.file_assets.map(&:lang)
        ui_langs.each { |ui_lang|
          my_logger.info("FileAssetDescription lang=#{ui_lang} desc=#{file_desc}")
          file_asset.file_asset_descriptions << FileAssetDescription.create(lang: ui_lang, filedesc: file_desc)
        }
      end

      unless dry_run
        Rails.env.production? ? file_asset.delay.update_playtime : file_asset.update_playtime
      end

    end

    my_logger.info("Finished %%%%%%%%%%%%%%%%%%%%%%%%%%")

    true
  end

  def self.my_logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/autoCatalogAssignment.log")
  end

  def self.get_catalogs_names(catalogs)
    catalogs.map(&:name).join(',')
  end

  def create_virtual_lesson
    return unless content_type_id == LESSON_CONTENT_TYPE_ID # Not a lesson
    return if virtual_lesson.present? # Already belongs to some virtual lesson
    return if secure != 0 # Ignore secure containers

    catalogs << LESSON_PART unless catalogs.include? LESSON_PART

    Container.my_logger.info("find/create_virtual_lesson for: #{filmdate} ...")

    self.virtual_lesson = VirtualLesson.where(film_date: filmdate).last ||
        VirtualLesson.create({ film_date: filmdate }, without_protection: true)
  end

  def self.parse_container_name(name, id)
    name            ||= Container.find(id).name
    sp              = ::StringParser.new name
    date            = sp.date
    language        = sp.language
    lecturer_id     = sp.lecturer_rav? ? Lecturer.rav.first.id : nil
    descriptions    = sp.descriptions
    catalogs        = descriptions.includes(:catalogs).select { |d| !d.catalogs.empty? }.first.try(:catalogs)
    content_type_id = sp.content_type.id
    security        = sp.content_security_level
    catalogs << LESSON_PART unless catalogs.include? LESSON_PART if content_type_id == LESSON_CONTENT_TYPE_ID

    [date, language, lecturer_id, descriptions, catalogs, content_type_id, security]
  end

  def set_updated_attributes(user, attributes)
    self.attributes     = attributes
    self.secure_changed = self.operator_changed_secure_field?(user)
    self.auto_parsed    = false
  end

  def operator_changed_secure_field?(user)
    if user.role?(:operator)
      changed_fields = self.changes
      changed_fields.size == 1 && changed_fields.has_key?('secure')
    else
      false
    end
  end

  def build_descriptions_and_translations(languages)
    lang_codes            = self.container_descriptions.map(&:lang)
    transcript_lang_codes = self.container_transcripts.map(&:lang)

    languages.each { |l|
      self.container_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
      self.container_transcripts.build(:lang => l.code3) unless  transcript_lang_codes.include?(l.code3)
    }
  end

end
