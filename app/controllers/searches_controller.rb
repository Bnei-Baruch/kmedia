class SearchesController < ApplicationController

  def index
    @search = Search.new
    success = set_fields
    @kuku = success
    #render((!success || @search.results.empty?) ? :error : :index)
  end


  private
  def set_fields
    if params[:search]
      @query = "#{params[:search][:search]}".gsub(/[_\-.]/, ' ')
    else
      @query = ''
    end
    @results = []
    return false if @query.empty?
    begin
      @results = Sunspot.search(Asset, Catalog, CatalogDescription, Lesson, LessonDescription) do |query|
        query.fulltext @query, :highlight => true
        query.paginate :page => params[:page], :per_page => 50000
        query.with(:secure, 0)
      end
    rescue Net::HTTPFatalError => e
      if e.data.kind_of?(Net::HTTPInternalServerError)
        if /<h1>([^\n]+)\n/ =~ e.data.body
          @results = "---- Solr exception -----#{$1}"
        end
      end
      return false
    rescue
      return false
    end
    true
  end

end
