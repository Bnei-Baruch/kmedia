class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :query_string, :content_type_id, :file_type_ids, :media_type_id, :date_type, :dates_range, :date_from, :date_to,
                :catalog_id, :catalog_ids, :model, :language_ids

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
      @catalog_ids = [string]
    end
  end

  def catalog_ids=(string)
    @catalog_ids = string.empty? ? nil : string.split(/\s*,\s*/)
  end

  def content_type
    @content_type ||= content_type_id.blank? ?  'all' : ContentType.find(content_type_id).pattern
  end

  def file_type_ids=(ids)
    @file_type_ids = ids.select { |id| id.present? }
  end

  def media_type_id=(name)
    @media_type_id = (name == 'all' || name.blank?) ? nil : name
    @media_exts = @media_type_id.nil? ? [] : FileType.where(:typename => (name == 'image' ? 'graph' : name)).first.try(:extlist).try(:send, :split, ',')
  end

  def media_type
    media_type_id || 'all'
  end

  def language_ids=(name)
    @language_ids, @language_exts = (name == 'all' || name.blank?) ? [nil, []] : [name, [name]]
  end

  def language
    language_ids || 'all'
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

  def search_full_text(page_no)
    query_text = query_string_normalized
    begin
      Lesson.search(include: [:content_type, :file_assets, :lesson_descriptions]) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 30
        query.with(:secure, 0)
        query.with(:content_type_id, @content_type_id) if @content_type_id.present?
        query.with(:file_language_ids).any_of @language_exts if @language_ids.present?
        query.with(:media_type_ids).any_of @media_exts if @media_type_id.present?
        query.with(:catalog_ids).any_of @catalog_ids if @catalog_ids.present?

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
    begin
      Sunspot.search(models) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 40
        query.order_by order
      end
    rescue Net::HTTPFatalError => e
      @error = set_search_network_error(e)
      false
    rescue
      "---- Solr exception: #{$!}"
    end
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

end
