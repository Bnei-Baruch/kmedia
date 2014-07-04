class Lesson < ActiveRecord::Base
  self.primary_key = :lessonid
  has_many :lessondesc_patterns, foreign_key: :lessonid
  has_many :lesson_descriptions, foreign_key: :lessonid do
    def by_language(code3)
      where(lang: code3)
    end
  end
  has_many :lesson_transcripts, foreign_key: :lessonid do
    def by_language(code3)
      where(lang: code3)
    end
  end
  belongs_to :lecturer, foreign_key: :lecturerid
  belongs_to :content_type
  belongs_to :virtual_lesson
  has_and_belongs_to_many :file_assets, join_table: 'lessonfiles', foreign_key: 'lessonid', association_foreign_key: 'fileid', order: 'date(updated) DESC, filename ASC'
  has_and_belongs_to_many :catalogs, join_table: 'catnodelessons', foreign_key: 'lessonid', association_foreign_key: 'catalognodeid', order: 'catalognodename'
  belongs_to :language, foreign_key: :lang, primary_key: :code3

  has_and_belongs_to_many :labels, uniq: true
  belongs_to :user

  before_destroy do |lesson|
    lesson.file_assets.each do |a|
      # Do not destroy files that belongs to more than one container
      a.delete if a.lesson_ids.length == 1
    end

    # remove empty virtual lessons
    lesson.virtual_lesson && lesson.virtual_lesson.destroy
  end

  LESSON_CONTENT_TYPE_ID = ContentType::CONTENT_TYPE_ID['lesson']
  LESSON_PART            = Catalog.where(catalognodename: 'lessons-part').first
  VIDEO_CATALOG          = Catalog.where(catalognodename: 'Video').first

  accepts_nested_attributes_for :lesson_descriptions, :lesson_transcripts

  attr_accessor :v_lessondate, :catalog_tokens, :rss, :label_tokens
  attr_accessor :container_ids

  validates :lessonname, :lang, :catalogs, :content_type_id, :presence => true

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
      record.lesson_descriptions.map { |x| lds[x.lang] = x.lessondesc }
      if lds['ENG'].blank? || lds['RUS'].blank? || lds['HEB'].blank?
        record.errors[:base] << "Empty Basic Description(s)"
      end
    end
  end
  validates_with NonemptyValidator

  before_create :create_timestamps
  before_update :update_timestamps

  scope :ordered, order("date(created) DESC, lessonname ASC")
  scope :need_update, where(<<-NEED_UPDATE
    date(created) > '2011-03-01' AND
    (
      lessondate IS NULL OR
      lang IS NULL OR
      lang = '' OR
      (SELECT count(1) FROM lessondesc WHERE lessondesc.lessonid = lessons.lessonid AND lang IN('HEB', 'ENG', 'RUS') AND length(lessondesc) > 0 ) = 0 OR
      (SELECT count(1) FROM catnodelessons WHERE catnodelessons.lessonid = lessons.lessonid) = 0 OR
      auto_parsed = TRUE
    )
  NEED_UPDATE
  )
  scope :for_censorship, -> { where(for_censorship: true) }
  scope :not_for_censorship, -> { where(for_censorship: false) }
  scope :secure_changed, -> { where(secure_changed: true) }
  scope :no_files, -> { where('(SELECT count(1) FROM lessonfiles WHERE lessonfiles.lessonid = lessons.lessonid) = 0') }

  scope :lost, -> { where(<<-LOST
      lessonid not in
        (SELECT distinct lessonid from catnodelessons INNER JOIN `catalognode` ON `catalognode`.`catalognodeid` = `catnodelessons`.`catalognodeid` WHERE
        (catalognodename NOT IN ('Lessons','lesson_first-part','lesson_second-part','lesson_third-part','lesson_fourth-part',
        'lesson_fifth-part','RSS_update','Video','Audio')))
  LOST
  ) }

  scope :security, -> sec { where(secure: sec) }
  scope :non_secure, -> { where(secure: 0) }

  def self.last_lectures_programs(lesson_date = Date.today, language = 'ENG')
    joins(:file_assets).where('files.filelang' => language).where(lessondate: lesson_date).where(content_type_id: [ContentType::CONTENT_TYPE_ID['lecture'], ContentType::CONTENT_TYPE_ID['program']])
  end


  def self.available_languages(lessons)
    return nil if lessons.nil?
    FileAsset.available_languages lessons.map(&:file_assets).flatten.sort.uniq.compact
  end

  def self.get_all_descriptions(lessons)
    Lesson.where(lessonid: lessons).includes(:lesson_descriptions).all.inject({}) do |all, lesson|
      all[lesson.id] = lesson.lesson_descriptions
      all
    end
  end

  def to_label
    lessonname
  end

  searchable(include: [:lesson_descriptions, :file_assets, :catalogs]) do
    text :lessonname, as: :kmedia

    text :description, as: :kmedia do
      lesson_descriptions.pluck('CONCAT(COALESCE(lessondesc,""), COALESCE(descr,""))').join(' ').gsub!(/[^[:print:]]/i, '')
    end

    integer :secure
    integer :content_type_id

    string :file_language_ids, :multiple => true do
      file_assets.pluck('distinct filelang')
    end

    string :media_type_ids, :multiple => true do
      file_assets.pluck('distinct filetype')
    end

    integer :catalog_ids, :multiple => true

    time :lessondate
    time :created
    time :updated

    boolean :for_censorship
    boolean :closed_by_censor
  end

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

  # Virtual column to emulate varchar lessondate in db
  columns_hash["v_lessondate"] = ActiveRecord::ConnectionAdapters::Column.new("v_lessondate", nil, "date")

  def v_lessondate
    Date.strptime(lessondate.to_s, '%Y-%m-%d') rescue nil
  end

  def v_lessondate=(my_date)
    self.lessondate = my_date.to_s
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

  def self.get_appropriate_lessons(filter, security)
    case filter
    when 'all'
      Lesson
    when 'secure_changed'
      Lesson.secure_changed
    when 'no_files'
      Lesson.no_files
    when 'lost'
      Lesson.lost
    when 'by_security'
      Lesson.security(security)
    else
      Lesson.need_update
    end.where(for_censorship: false)
  end

  def self.get_lesson_title(id, language)
    lesson = Lesson.find(id) rescue { lessonname: '----------', lessondate: '1970-01-01', created: '1970-01-01' }
    descr             = lesson.lesson_descriptions.by_language(language).first.try(:lessondesc)
    descr             = lesson.lesson_descriptions.by_language('ENG').first.try(:lessondesc) if descr.blank?
    lesson.lessonname = descr if descr

    if descr && (lesson.catalogs.map(&:id) & [3606, 3661, 3662]).empty?
      nil
    else
      lesson.lessonname +
          (lesson.lessondate.to_s == '0000-00-00' ? '' : " (#{lesson.lessondate})")
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
    container = Lesson.where(lessonname: container_name).first_or_initialize do |c|
      # Update fields for new container only
      return unless c.new_record?

      # Try to update auto-fill-able fields
      c.catalogs << VIDEO_CATALOG unless c.catalogs.include? VIDEO_CATALOG
      my_logger.info("Catalogs after video assignment: #{get_catalogs_names(c.catalogs)}")

      sp = ::StringParser.new container_name
      c.lessondate = Date.new(sp.date[0], sp.date[1], sp.date[2]).to_s rescue Time.now.to_date
      c.lang = sp.language.upcase rescue 'ENG'
      c.lecturerid = Lecturer.rav.first.lecturerid if sp.lecturer_rav?
      sp.descriptions.includes(:catalogs).each { |pattern|
        c.lesson_descriptions.build(lang: pattern.lang, lessondesc: pattern.description)
        pattern.catalogs.each { |pc|
          c.catalogs << pc unless c.catalogs.include? pc
        }
      }
      my_logger.info("Catalogs after assignment from pattern: #{get_catalogs_names(c.catalogs)}")
      c.content_type_id = sp.content_type.id
      c.secure          = sp.content_security_level
      c.auto_parsed     = true

      lang_codes = c.lesson_descriptions.map(&:lang)
      Language::ALL_LANGUAGES.each { |l|
        c.lesson_descriptions.build(lang: l.code3) unless lang_codes.include?(l.code3)
      }
      c.create_virtual_lesson unless dry_run
    end
    my_logger.info("Catalogs before save: #{get_catalogs_names(container.catalogs)}")

    if !dry_run && container.position.blank?
      container.position = (container.virtual_lesson.lessons.count + 1) rescue 0
    end

    container.save!(:validate => false) unless dry_run
    my_logger.info("Container saved")

    (files || []).each do |file|
      name   = file['file']
      server = file['server'] || DEFAULT_FILE_SERVER
      size   = file['size'] || 0
      datetime = file['time'] ? Time.at(file['time']) : Time.now rescue raise("Wrong :time value: #{file['time']}")

      extension = File.extname(name) rescue raise("Wrong :file value (Unable to detect file extension): #{name}")
      extension = extension[1..-1] # Skip '.' in the beginning of extension, i.e. .mp3 => mp3

      file_asset = FileAsset.find_by_filename(name)

      playtime_secs = file['playtime_secs'].to_i

      my_logger.info("File name=#{name} server=#{server} size=#{size} datetime=#{datetime} extension=#{extension} playtime_secs=#{playtime_secs}")

      if file_asset.nil?
        # New file
        name =~ /^([^_]+)_/
        lang = Language.find_by_code3($1.upcase).code3 rescue 'ENG'
        sp     = ::StringParser.new name
        secure = sp.content_security_level

        file_asset = FileAsset.new(filename:      name, filelang: lang, filetype: extension, filedate: datetime, filesize: size,
                                   playtime_secs: playtime_secs, lastuser: 'system', servername: server, secure: secure)
        my_logger.info("New file lang=#{lang} secure=#{secure}")
      elsif !dry_run
        my_logger.info("Existing file, just update")
        file_asset.update_attributes(filedate: datetime, filesize: size, playtime_secs: playtime_secs, lastuser: 'system', servername: server)
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
        ui_langs = Language.all.map(&:code3) - container.file_assets.select('distinct filelang').map(&:filelang)
        ui_langs.each { |ui_lang|
          my_logger.info("FileAssetDescription lang=#{ui_lang} file_desc=#{file_desc}")
          file_asset.file_asset_descriptions << FileAssetDescription.new(lang: ui_lang, filedesc: file_desc)
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
    catalogs.map(&:catalognodename).join(',')
  end

  def create_virtual_lesson
    return unless content_type_id == LESSON_CONTENT_TYPE_ID # Not a lesson
    return if virtual_lesson.present? # Already belongs to some virtual lesson
    return if secure != 0 # Ignore secure containers

    catalogs << LESSON_PART unless catalogs.include? LESSON_PART

    Lesson.my_logger.info("find/create_virtual_lesson for: #{lessondate} ...")

    self.virtual_lesson = VirtualLesson.where(film_date: lessondate).last ||
        VirtualLesson.create({ film_date: lessondate }, without_protection: true)
  end

  def self.parse_lesson_name(lessonname, id)
    lessonname      ||= Lesson.find(id).lessonname
    sp              = ::StringParser.new lessonname
    date            = sp.date
    language        = sp.language
    lecturerid      = sp.lecturer_rav? ? Lecturer.rav.first.lecturerid : nil
    descriptions    = sp.descriptions
    catalogs        = descriptions.includes(:catalogs).select { |d| !d.catalogs.empty? }.first.try(:catalogs)
    content_type_id = sp.content_type.id
    security        = sp.content_security_level
    catalogs << LESSON_PART unless catalogs.include? LESSON_PART if content_type_id == LESSON_CONTENT_TYPE_ID

    [date, language, lecturerid, descriptions, catalogs, content_type_id, security]
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
    lang_codes            = self.lesson_descriptions.map(&:lang)
    transcript_lang_codes = self.lesson_transcripts.map(&:lang)

    languages.each { |l|
      self.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
      self.lesson_transcripts.build(:lang => l.code3) unless  transcript_lang_codes.include?(l.code3)
    }
  end

end
