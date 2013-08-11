class UiController < ApplicationController

  before_filter :setup

  # Homepage
  def homepage
    last_virtual_lesson, @prev_lesson, @next_lesson = VirtualLesson.last_lesson(params[:id])

    @last_lessons = last_virtual_lesson.lessons_ordered_by_parts
    @lesson_name = last_virtual_lesson.virtual_name(@language)

    @available_last_lessons_languages = FileAsset.insecure.available_languages(@last_lessons.map(&:file_assets).flatten)
    @active_tab = @available_last_lessons_languages.include?(@locale) ? @locale : 'all'

    @updated_assets = FileAsset.latest_updates(params[:amount_of_updated].to_i > 0 ? params[:amount_of_updated].to_i : 25).includes(:file_asset_descriptions)
    @available_updated_assets_languages = FileAsset.available_languages(@updated_assets)

    search = Search.new({date_type: 'one_day', dates_range: (Time.now - 7.days).to_s, per_page: 100})
    results = search.search_full_text
    @new_materials = results.results rescue []
    @descriptions = Lesson.get_all_descriptions(@new_materials)

    render :homepage
  end
  alias_method :homepage_show, :homepage

  # Search result
  def index
    @results = @search.search_full_text params[:page]
    @hits = @results.try(:hits)
    @total = @results.try(:total)
    @no_results = @results.is_a?(String) || !@results || @results.results.empty?

    @results = @results.results
    @descriptions = Lesson.get_all_descriptions(@results)
  end

  # Show specific item page
  def show
    @item = Lesson.find params[:id]
    @available_languages = FileAsset.available_languages(@item.file_assets)
    @descriptions = Lesson.get_all_descriptions(@item)
  end

  private

  def setup
    @language = Language.where(locale: @locale).pluck(:code3).first
    @boost_tree = Catalog.boost_json(@language)
    @selected_catalogs = Catalog.selected_catalogs(@language)
    @search = Search.new(params[:search])
  end
end
