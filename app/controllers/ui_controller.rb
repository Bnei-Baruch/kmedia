class UiController < ApplicationController

  before_filter :setup

  # Homepage
  def homepage
    @updated_assets = FileAsset.latest_updates(params[:amount_of_updated].to_i > 0 ? params[:amount_of_updated].to_i : 25).includes(:file_asset_descriptions)
    @available_updated_assets_languages = FileAsset.available_languages(@updated_assets)

    search = Search.new({date_type: 'one_day', dates_range: (Time.now - 7.days).to_s, per_page: 100})
    results = search.search_full_text
    @new_materials = results.results rescue []
    @descriptions = Lesson.get_all_descriptions(@new_materials)

    last_virtual_lesson, @prev_lesson, @next_lesson = VirtualLesson.last_lesson(params[:lesson_date] || params[:id])
    if last_virtual_lesson
      @last_lessons = last_virtual_lesson.lessons_ordered_by_parts
      @lesson_name = last_virtual_lesson.virtual_name

      @available_last_lessons_languages = FileAsset.insecure.available_languages(@last_lessons.map(&:file_assets).flatten)
      @active_tab = @available_last_lessons_languages.include?(@locale) ? @locale : 'all'
    else
      @lesson_date = params[:lesson_date]
    end

    render :homepage
  end
  alias_method :homepage_show, :homepage

  # Search result
  def index
    @results = @search.search_full_text params[:page]
    @hits = @results.try(:hits)
    @total = @results.try(:total)
    @no_results = @results.is_a?(String) || !@results || @results.results.empty?

    @results = @results.try(:results)
    @descriptions = Lesson.get_all_descriptions(@results)
  end

  # Show specific item page
  def show
    @item = Lesson.find params[:id]
    @available_languages = FileAsset.available_languages(@item.file_assets)
    @descriptions = Lesson.get_all_descriptions(@item)
  end

  def google_ads
  end

  def lesson_downloader
    @manual_lang = case @locale
                   when 'en', 'he', 'ru'
                     @locale
                   else
                     'en'
                   end
  end

  private

  def setup
    @language = Language::LOCALE_CODE3[@locale]
    @boost_tree = Catalog.boost_json(@language)
    @selected_catalogs = Catalog.selected_catalogs(@language)
    @books_catalog = Catalog.books_catalog(@language).try(:first)
    @search = Search.new(params[:search])
  end
end
