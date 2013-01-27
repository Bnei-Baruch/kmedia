class Lesson < ActiveRecord::Base
  self.primary_key = :lessonid
  has_many :lessondesc_patterns, :foreign_key => :lessonid
  has_many :lesson_descriptions, :foreign_key => :lessonid do
    def by_language(code3)
      where(:lang => code3)
    end
  end
  has_many :lesson_transcripts, :foreign_key => :lessonid do
    def by_language(code3)
      where(:lang => code3)
    end
  end
  belongs_to :lecturer, :foreign_key => :lecturerid
  belongs_to :content_type
  belongs_to :virtual_lesson
  has_and_belongs_to_many :file_assets, :join_table => "lessonfiles", :foreign_key => "lessonid",
                          :association_foreign_key => "fileid", :order => "date(updated) DESC, filename ASC"
  has_and_belongs_to_many :catalogs, :join_table => "catnodelessons", :foreign_key => "lessonid",
                          :association_foreign_key => "catalognodeid", :order => "catalognodename"
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  has_and_belongs_to_many :labels, uniq: true

  before_destroy do |lesson|
    lesson.file_assets.each { |a|
      # Do not destroy files that belongs to more than one container
      a.delete if a.lesson_ids.length == 1
    }
  end

  LESSON_CONTENT_TYPE_ID = ContentType.find_by_pattern('lesson').id
  PREPARATION = Catalog.find_by_catalognodename('lesson_preparation').id
  FIRST_PART = Catalog.find_by_catalognodename('lesson_first-part').id
  SECOND_PART = Catalog.find_by_catalognodename('lesson_second-part').id
  THIRD_PART = Catalog.find_by_catalognodename('lesson_third-part').id
  FOURTH_PART = Catalog.find_by_catalognodename('lesson_fourth-part').id
  FIFTH_PART = Catalog.find_by_catalognodename('lesson_fifth-part').id

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
        return
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
  scope :secure_changed, where(:secure_changed => true)
  scope :no_files, where(<<-NO_FILES
  (SELECT count(1) FROM lessonfiles WHERE lessonfiles.lessonid = lessons.lessonid) = 0
  NO_FILES
  )

  scope :lost, where(<<-LOST
  lessonid not in
    (SELECT distinct lessonid from catnodelessons INNER JOIN `catalognode` ON `catalognode`.`catalognodeid` = `catnodelessons`.`catalognodeid` WHERE
    (catalognodename NOT IN ('Lessons','lesson_first-part','lesson_second-part','lesson_third-part','lesson_fourth-part',
    'lesson_fifth-part','RSS_update','Video','Audio')))
  LOST
  )

  scope :security, lambda { |sec| where(:secure => sec) }

  def to_label
    lessonname
  end

  searchable do
    text :lessonname
    text :lessondesc, :as => :user_text do
      lesson_descriptions.select([:lessondesc, :descr]).map(&:lessondesc).join(' ')
    end
    text :descr, :as => :user_text do
      lesson_descriptions.select([:lessondesc, :descr]).map(&:descr).join(' ')
    end
    text :transcript, :as => :user_text do
      lesson_transcripts.select([:transcript]).map(&:transcript).join(' ')
    end

    integer :secure
    integer :content_type_id

    string :file_language_ids, :multiple => true do
      file_assets.select('distinct filelang').map(&:filelang)
    end

    string :media_type_ids, :multiple => true do
      file_assets.select('distinct filetype').map(&:filetype)
    end

    integer :catalog_ids, :multiple => true

    time :lessondate
    time :created
    time :updated
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

  def self.last_lesson(before_lesson, after_lesson)
    if before_lesson
      last_date = VirtualLesson.find(before_lesson).created_at
      ll = VirtualLesson.where('created_at < ?', last_date).order('created_at desc').first
      next_lesson = true
      prev_lesson = VirtualLesson.where('created_at < ?', ll.created_at).count > 0
    elsif after_lesson
      last_date = VirtualLesson.find(after_lesson).first.created_at
      ll = VirtualLesson.where('created_at > ?', last_date).order('created_at desc').first
      prev_lesson = true
      next_lesson = VirtualLesson.where('created_at > ?', ll.created_at).count > 0
    else
      ll = VirtualLesson.last
      prev_lesson = VirtualLesson.where('created_at < ?', ll.created_at).count > 0
      next_lesson = false
    end
    [ll, prev_lesson, next_lesson]
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
    container = Lesson.find_or_initialize_by_lessonname(container_name) { |c|
      # Update fields for new container only
      if c.new_record?
        # Try to update auto-fill-able fields
        # Only for new containers
        video = Catalog.find_by_catalognodename('Video') rescue raise('Unable to find catalog "Video"')
        c.catalogs << video unless c.catalogs.include? video
        my_logger.info("Catalogs after video assignment: #{get_catalogs_names(c.catalogs)}")
        sp = ::StringParser.new container_name
        c.lessondate = Date.new(sp.date[0], sp.date[1], sp.date[2]).to_s rescue Time.now.to_date
        c.lang = sp.language.upcase rescue 'ENG'
        c.lecturerid = Lecturer.rav.first.lecturerid if sp.lecturer_rav?
        sp.descriptions.each { |pattern|
          c.lesson_descriptions.build(:lang => pattern.lang, :lessondesc => pattern.description)
          pattern.catalogs.each { |pc|
            c.catalogs << pc unless c.catalogs.include? pc
          }
        }
        my_logger.info("Catalogs after assignment from pattern: #{get_catalogs_names(c.catalogs)}")
        c.content_type_id = sp.content_type.id
        c.secure = sp.content_security_level
        c.auto_parsed = true

        languages = Language.order('code3').all

        lang_codes = c.lesson_descriptions.map(&:lang)
        languages.each { |l|
          c.lesson_descriptions.build(:lang => l.code3) unless lang_codes.include?(l.code3)
        }
        AutoCatalogAssignment.match_catalog(c) unless dry_run
        create_virtual_lesson(c) unless dry_run
      end
    }
    my_logger.info("Catalogs before save: #{get_catalogs_names(container.catalogs)}")

    container.save!(:validate => false) unless dry_run

    (files || []).each do |file|
      name = file['file']
      server = file['server'] || DEFAULT_FILE_SERVER
      size = file['size'] || 0
      datetime = file['time'] ? Time.at(file['time']) : Time.now rescue raise("Wrong :time value: #{file['time']}")

      extension = File.extname(name) rescue raise("Wrong :file value (Unable to detect file extension): #{name}")
      extension = extension[1..3] # Skip '.' in the beginning of extension, i.e. .mp3 => mp3

      file_asset = FileAsset.find_by_filename(name)

      playtime_secs =
          if dry_run
            my_logger.info("DRU_RUN; 0 secs")
            0
          else
            begin
              my_logger.info("WET_RUN; ??? secs")
              secs = file['playtime_secs'].to_i > 0 ? file['playtime_secs'].to_i :
                  if extension == 'mp3'
                    m = Mp3Info.open(open(server.httpurl + '/' + name))
                    my_logger.info("WET_RUN; MP3 #{m.length.round(0)} secs")
                    m.length.round(0)
                  elsif extension == 'wma' || extension == 'wmv' || extension == 'asf'
                    f = WmaInfo.new(open(server.httpurl + '/' + name))
                    my_logger.info("WET_RUN; WMA #{f.info['playtime_seconds']} secs")
                    f.info['playtime_seconds']
                  end || 0
              my_logger.info("WET_RUN; #{secs} secs FIN")
            rescue
              my_logger.info("WET_RUN; UPS")
              0
            end
          end

      if file_asset.nil?
        # New file
        name =~ /^([^_]+)_/
        lang = Language.find_by_code3($1.upcase).code3 rescue 'ENG'
        sp = ::StringParser.new name
        secure = sp.content_security_level

        file_asset = FileAsset.new(filename: name, filelang: lang, filetype: extension, filedate: datetime, filesize: size,
                                   playtime_secs: playtime_secs, lastuser: 'system', servername: server, secure: secure)
      elsif !dry_run
        file_asset.update_attributes(filedate: datetime, filesize: size, playtime_secs: playtime_secs, lastuser: 'system', servername: server)
      end

      if !dry_run && !container.file_asset_ids.include?(file_asset.id)
        container.file_assets << file_asset
        raise "Unable to save/update file #{name}" unless file_asset.save
      end

      # Update file description for non-existing UI languages
      file_desc = if name =~ /_draw_/
                    extension.downcase == 'zip' ? '<b>draw ZIP</b>' : '<b>draw</b>'
                  elsif name =~ /_scan_/
                    extension.downcase == 'zip' ? '<b>scan ZIP</b>' : '<b>scan</b>'
                  else
                    case extension.downcase.downcase
                      when '.zip'
                        '<b>ZIP FILE</b>'
                      when '.pdf'
                        '<b>pdf</b>'
                      when '.flv'
                        '<b>flv</b>'
                      when '.mp4'
                        '<b>mp4</b>'
                      else
                        if name =~ /_96k/
                          '2/2 <b>original 96K</b>'
                        end
                    end
                  end
      unless file_desc.blank?
        ui_langs = Language.all.map(&:code3) - container.file_assets.select('distinct filelang').map(&:filelang)
        ui_langs.each { |ui_lang|
          file_asset.file_asset_descriptions << FileAssetDescription.new(lang: ui_lang, filedesc: file_desc)
        }
      end
    end

    true
  end

  def self.my_logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/autoCatalogAssignment.log")
  end

  def self.get_catalogs_names(catalogs)
    names = []
    catalogs.each { |c|
      names << c.catalognodename
    }
    names.join(',')
  end

  def self.create_virtual_lesson(container)
    return unless container.content_type_id == LESSON_CONTENT_TYPE_ID # Not a lesson
    return if container.virtual_lesson.present? # Already belongs to some virtual lesson

    ids = container.catalogs.map(&:id)
    if ids.include?(FIRST_PART) ||
        ids.include?(SECOND_PART) ||
        ids.include?(THIRD_PART) ||
        ids.include?(FOURTH_PART) ||
        ids.include?(FIFTH_PART)
      # first_part - create a new container or add to last_container
      # second_part...fifth_part - add to last_container
      vl = VirtualLesson.last
      vl = nil if vl.film_date != container.lessondate # first part without preparation or non-first part comes first... happens...
    end

    vl = VirtualLesson.create({film_date: container.lessondate}, without_protection: true) unless vl
    container.virtual_lesson = vl
  end

end
