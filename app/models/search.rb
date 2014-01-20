class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :query_string, :content_type_id, :file_type_ids, :media_type_id, :media_type_ids, :date_type, :dates_range, :date_from, :date_to,
                :catalog_id, :catalog_ids, :model, :language_ids, :created_from_date, :per_page

  attr_accessor :error

  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end if attributes
    @error = nil
  end

  def self.models
    [['-- All Kinds --', ''],
     ['Files', FileAsset],
     ['Catalogs', Catalog],
     ['Catalog Descriptions', CatalogDescription],
     ['Container', Lesson],
     ['Container Description (Long/Short)', LessonDescription],
     ['Container Pattern', LessondescPattern]
    ]
  end

  def persisted?
    false
  end

  def query_string_normalized
    query_string.gsub(/[_\-.]/, ' ') rescue nil
  end

  def date_type_text
    @date_type_text ||= date_type || I18n.t('ui.sidebar.anytime')
  end

  def catalog_id=(string)
    unless string.empty?
      @catalog_id = string
      @catalog_ids = [string.to_i]
    end
  end

  def catalog_ids=(string)
    @catalog_ids = if string.blank?
                     nil
                   else
                     if string =~ /^\d+$/
                       [string.to_i]
                     else
                       JSON.parse(string) rescue string.split(/\s*,\s*/)
                     end
                   end
  end

  def content_type
    @content_type ||= content_type_id.blank? ? 'all' : ContentType.find(content_type_id).pattern
  end

  def file_type_ids=(ids)
    @file_type_ids = ids.select { |id| id.present? }
  end

  def media_type_id=(name)
    @media_type_id = (name == 'all' || name.blank?) ? nil : name
    @media_exts = @media_type_id.nil? ? [] : FileType.where(:typename => (name == 'image' ? 'graph' : name)).first.try(:extlist).try(:send, :split, ',')
  end

  def media_type_ids=(ids)
    @media_type_id = ids ? ids.split(/\s*,\s*/) : []
    @media_exts = @media_type_id.inject([]) do |result, media_type|
      result << FileType.where(:typename => (media_type == 'image' ? 'graph' : media_type)).first.try(:extlist).try(:send, :split, ',')
    end.flatten
  end

  def media_type
    media_type_id || 'all'
  end

  def language_ids=(name)
    @language_ids, @language_exts = (name == 'all' || name.blank?) ? [nil, []] : [name, [name]]
  end


  # @param ids - language ids, if multiple, will be a comma separated string
  # @language_exts will contain the code3
  def language_by_id=(ids)
    @language_ids = ids ? ids.split(/\s*,\s*/) : nil
    @language_exts = Language.find(@language_ids).collect(&:code3)
  end

  def language
    language_ids || 'all'
  end

  def content_type_ids=(ids)
    @content_type_id = ids
    @content_type_ids = ids ? ids.split(/\s*,\s*/) : nil

  end

  def date_from=(date)
    @date_from = parse_time(date)
  end

  def date_to=(date)
    @date_to = parse_time(date)
  end

  def created_from_date=(date)
    @created_from_date = parse_time(date)
  end


  def date_one_day
    Time.parse(@dates_range)
  end

  def date_range
    begin
      m = /^([a-zA-Z0-9\s,]+).*?\s([a-zA-Z0-9\s,]+)$/.match(@dates_range)
      [Time.parse(m[1]), Time.parse(m[2])]
    rescue
      [nil, nil]
    end
  end

  def dates_range_text
    dates_range || I18n.t('ui.sidebar.anytime')
  end

  def search_full_text(page_no = nil)
    query_text = query_string_normalized
    begin
      Lesson.search(include: [:content_type, :file_assets, :lesson_descriptions]) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => per_page.present? ? per_page : 30
        query.with(:secure, 0)
        query.with(:for_censorship, false)
        query.with(:closed_by_censor, false)
        query.with(:content_type_id, @content_type_id) if @content_type_id.present?
        query.with(:file_language_ids).any_of @language_exts if @language_ids.present?
        query.with(:media_type_ids).any_of @media_exts if @media_type_id.present?
        query.with(:catalog_ids).any_of @catalog_ids if @catalog_ids.present?
        query.with(:lessondate).between Range.new(@date_from, @date_to) if @date_from.present? && @date_to.present?
        query.with(:lessondate).greater_than_or_equal_to(@date_from) if @date_from.present? && @date_to.blank?
        query.with(:lessondate).less_than_or_equal_to(@date_to) if @date_to.present? && @date_from.blank?
        query.with(:created).greater_than(@created_from_date) if @created_from_date.present?

        case @date_type
          when 'one_day'
            date = date_one_day
            query.with(:lessondate).between Range.new(date.beginning_of_day, date.end_of_day)
          when 'range'
            beginning, ending = date_range
            query.with(:lessondate).between Range.new(beginning.beginning_of_day, ending.end_of_day) unless beginning.nil? || ending.nil?
        end

        query.order_by :lessondate, :desc
      end
    rescue Net::HTTPFatalError => e
      @error = set_search_network_error(e)
      false
    rescue
      @error = "---- Solr exception -----#{$!}"
      false
    end
  end

  def search_full_text_admin(page_no)
    query_text = query_string_normalized
    if model.blank?
      models = [FileAsset, Catalog, CatalogDescription, Lesson, LessonDescription, LessondescPattern]
    else
      models = [model.constantize]
    end
    order = :score
    censorship = models.include? Lesson
    begin
      Sunspot.search(models) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 40
        query.order_by order
        query.with(:for_censorship, false) if censorship
        query.with(:closed_by_censor, false) if censorship
      end
    rescue Net::HTTPFatalError => e
      @error = set_search_network_error(e)
      false
    rescue
      "---- Solr exception: #{$!}"
    end
  end


  # for the personal library files search
  def search_full_text_files()
    query_text = query_string_normalized
    FileAsset.search_ids do |query|
      query.fulltext query_text unless query_text.blank?
      query.paginate :page => 1, :per_page => per_page
      query.with(:secure, 0)
      query.with(:for_censorship, false)
      query.with(:closed_by_censor, false)
      query.with(:content_type_ids).any_of @content_type_ids if @content_type_ids.present?
      query.with(:filelang).any_of @language_exts if @language_exts.present?
      query.with(:filetype).any_of @media_exts if @media_type_id.present?
      query.with(:catalog_ids).any_of @catalog_ids if @catalog_ids.present?
      query.with(:filedate).between Range.new(@date_from, @date_to) if @date_from.present? && @date_to.present?
      query.with(:filedate).greater_than(@date_from) if @date_from.present? && @date_to.blank?
      query.with(:filedate).less_than(@date_to) if @date_to.present? && @date_from.blank?
      query.with(:created).greater_than(@created_from_date) if @created_from_date.present?
    end
  rescue Net::HTTPFatalError => e
    @error = set_search_network_error(e)
    false
  rescue
    "---- Solr exception: #{$!}"
  end


  private
  def set_search_error(e)
    if e.data.kind_of?(Net::HTTPInternalServerError)
      if /<h1>([^\n]+)\n/ =~ e.data.body
        "---- Solr exception: #{$1}"
      else
        "---- Solr exception: #{$!}"
      end
    end
  end

  def parse_time(time)
    Time.parse(time) rescue nil
  end

end
