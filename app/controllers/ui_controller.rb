class UiController < ApplicationController

  # Homepage
  def index
    @language = Language.find_by_locale(:en).code3
    @search = Search.new(params[:search])
    @results = @search.search_full_text params[:page]
  end

  # Search result
  def show
    @language = Language.find_by_locale(:en).code3
    @search = Search.new(params[:search])
    @results = @search.search_full_text params[:page]
  end

end
