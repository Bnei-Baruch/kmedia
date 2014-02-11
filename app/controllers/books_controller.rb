class BooksController < ApplicationController

  before_filter :setup

  def index
    @boost_tree = Catalog.boost_json(@language)
    @books_catalog = Catalog.books_catalog(@language).try(:first)
    @boost_tree = Catalog.boost_json(@language)

    @selected_catalogs = Catalog.selected_catalogs(@language)
    @search = Search.new(params[:search])
  end

  def show
  end

  private

  def setup
    @language = Language.where(locale: @locale).pluck(:code3).first
  end
end
