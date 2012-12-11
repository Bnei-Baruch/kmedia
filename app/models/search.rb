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

  def catalog_id=(string)
    @catalog_id = string
    @catalog_ids = string ? string.split(/\s*,\s*/) : nil
  end

  def language_ids=(ids)
    @language_ids = ids.select { |id| id.present? }
  end

  def file_type_ids=(ids)
    @file_type_ids = ids.select { |id| id.present? }
  end

  def media_type_id=(name)
    @media_type_id = (name == 'all' || name.blank?) ? nil : name
    @media_exts = (name == 'all' || name.blank?) ? [] : FileType.find_by_typename(name == 'image' ? 'graph' : name).extlist.split(',')
  end

  def content_type_id=(id)
    @content_type_id = id == '0' ? nil : id
  end

  def date_from
    if @date_type == 'range'
      m = /([^\s]+)\s+-\s+(.*)/.match(@dates_range)
      Time.parse(m[1])
    else
      Time.now
    end
  end

  def date_to
    if @date_type == 'range'
      m = /([^\s]+)\s+-\s+(.*)/.match(@dates_range)
      Time.parse(m[2])
    else
      Time.now
    end
  end

  def search_full_text(page_no)
    query_text = query_string_normalized
    begin
      Sunspot.search(Lesson) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 30
        query.with(:secure, 0)
        query.with(:content_type_id, @content_type_id) if @content_type_id.present?
        query.with(:file_language_ids).any_of @language_ids if @language_ids.present?
        query.with(:media_type_ids).any_of @media_exts if @media_type_id.present?
        query.with(:catalog_ids).any_of @catalog_ids if @catalog_ids.present?

        case @date_type
          when 'today'
            query.with(:lessondate).between Range.new(Time.now.beginning_of_day, Time.now.end_of_day)
          when 'this_week'
            query.with(:lessondate).between Range.new(Time.now.beginning_of_week, Time.now.end_of_week)
          when 'this_month'
            query.with(:lessondate).between Range.new(Time.now.beginning_of_month, Time.now.end_of_month)
          when 'this_year'
            query.with(:lessondate).between Range.new(Time.now.beginning_of_year, Time.now.end_of_year)
          when 'range'
            query.with(:lessondate).between Range.new(date_from, date_to)

          #query.with(:lessondate).between Range.new(@date_from, @date_to) if @date_from.present? && @date_to.present?
          #query.with(:lessondate).greater_than @date_from if @date_from.present? && !@date_to.present?
          #query.with(:lessondate).less_than @date_to if @date_to.present? && @date_to.present?
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
