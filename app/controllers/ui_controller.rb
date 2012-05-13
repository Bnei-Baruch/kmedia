class UiController < ApplicationController

  def index
    @language = Language.find_by_locale(:he).code3
    @search = Search.new(params[:search])
    @results = @search.search_full_text params[:page]
  end
end
