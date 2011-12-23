class Admin::SearchesController < ApplicationController
  before_filter :authenticate_user!

  def index
    success = set_fields
    render((!success || @search.results.empty?) ? :error : :index)
  end

  alias_method :create, :index

  private
  def set_fields
    if params[:search]
      @query = "#{params[:search][:search]}".gsub(/[_\-.]/, ' ')
    else
      @query = ''
    end
    @search = []
    return false if @query.empty?
    begin
      @search = Sunspot.search(Asset, Catalog, CatalogDescription, Lesson, LessonDescription, LessondescPattern) do |query|
        query.fulltext @query, :highlight => true
        query.paginate :page => params[:page], :per_page => 40
        #query.with(:secure, true)
      end
    rescue Net::HTTPFatalError => e
      if e.data.kind_of?(Net::HTTPInternalServerError)
        if /<h1>([^\n]+)\n/ =~ e.data.body
          @search = "---- Solr exception -----#{$1}"
        end
      end
      return false
    rescue
      return false
    end
    true
  end

end
