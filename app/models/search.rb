class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :query_string, :language_ids, :container_type_ids, :file_type_ids, :media_type_ids,
                :catalog_id, :catalog_ids, :date_from, :date_to

  attr_accessor :error

  def initialize(attributes = {})
    attributes.each do |name, value|
      send "#{name}=", value
    end if attributes
    @error = nil
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
    @language_ids = ids.select{|id| id.present?}
  end

  def file_type_ids=(ids)
    @file_type_ids = ids.select{|id| id.present?}
    @media_type_ids = ids.select{|id| id.present?}.map do |fname|
      FileType.find(fname).try(:extlist).split(',')
    end.flatten.uniq.compact
  end

  def container_type_ids=(ids)
    @container_type_ids = ids.select{|id| id.present?}
  end

  def date_to=(string)
    @date_to = string.to_date
  end

  def date_from=(string)
    @date_from = string.to_date
  end

  def search_full_text(page_no)
    query_text = query_string_normalized
    begin
      Sunspot.search(Lesson) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 30
        query.with(:secure, 0)
        query.with(:container_type_id).any_of @container_type_ids if @container_type_ids.present?
        query.with(:file_language_ids).any_of @language_ids if @language_ids.present?
        query.with(:media_type_ids).any_of @media_type_ids if @media_type_ids.present?
        query.with(:catalog_ids).any_of @catalog_ids if @catalog_ids.present?

        query.with(:lessondate).between Range.new(@date_from, @date_to) if @date_from.present? && @date_to.present?
        query.with(:lessondate).greater_than @date_from if @date_from.present?
        query.with(:lessondate).less_than @date_to if @date_to.present?
      end
    rescue Net::HTTPFatalError => e
      if e.data.kind_of?(Net::HTTPInternalServerError)
        if /<h1>([^\n]+)\n/ =~ e.data.body
          @error = "---- Solr exception -----#{$1}"
        else
          @error = "---- Solr exception -----#{$!}"
        end
        false
      end
    rescue
      @error = "---- Solr exception -----#{$!}"
      false
    end
  end

  def search_full_text_admin(page_no)
    query_text = query_string_normalized
    begin
      Sunspot.search(Asset, Catalog, CatalogDescription, Lesson, LessonDescription, LessondescPattern) do |query|
        query.fulltext query_text, :highlight => true unless query_text.blank?
        query.paginate :page => page_no, :per_page => 40
      end
    rescue Net::HTTPFatalError => e
      if e.data.kind_of?(Net::HTTPInternalServerError)
        if /<h1>([^\n]+)\n/ =~ e.data.body
          "---- Solr exception: #{$1}"
        else
          "---- Solr exception: #{$!}"
        end
      end
    rescue
      "---- Solr exception: #{$!}"
    end
  end

end
