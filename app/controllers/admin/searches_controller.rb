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
      @query = params[:search][:search].gsub(/[-_]/, ' ')
    else
      @query = ''
    end
    @search = [] and return false if @query.empty?
    @search = Sunspot.search(Asset, Catalog, Lesson, LessonDescription, LessondescPattern) do |query|
      query.keywords @query, :highlight => true
      query.paginate :page => params[:page], :per_page => 40
      query.with(:secure, true)
    end
    true
  end

end
