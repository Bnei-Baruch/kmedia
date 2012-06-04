class Admin::SearchesController < Admin::ApplicationController

  def index
    @search = Search.new(params[:search])
    @results = @search.search_full_text_admin params[:page]
  end
end
