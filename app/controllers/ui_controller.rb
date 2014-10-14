class UiController < ApplicationController

  before_filter :setup

  # Homepage
  def homepage
    last_virtual_lesson = VirtualLesson.last_lesson(params[:lesson_date] || params[:id])
    set_virtual_lesson last_virtual_lesson
    set_independent_parts

    begin
      render :homepage
    rescue Exception => e
      redirect_to '/'
    end
  end

  alias_method :homepage_show, :homepage

  def next_lesson
    last_virtual_lesson = VirtualLesson.next_lesson(params[:id])
    set_virtual_lesson last_virtual_lesson
    set_independent_parts

    render :homepage
  end

  def prev_lesson
    last_virtual_lesson = VirtualLesson.prev_lesson(params[:id])
    set_virtual_lesson last_virtual_lesson
    set_independent_parts

    render :homepage
  end

  # Search result
  def index
    @results    = @search.search_full_text params[:page]
    @hits       = @results.try(:hits) rescue nil
    @total      = @results.try(:total)  rescue nil
    @no_results = @results.is_a?(String) || !@results || @results.results.empty?

    @results      = @results.try(:results) rescue nil
    @descriptions = Container.get_all_descriptions(@results) rescue nil
  end

  # Show specific item page
  def show
    @item                               = Container.where(id: params[:id]).non_secure.first
    @available_languages, @descriptions = @item ? [FileAsset.available_languages(@item.file_assets), Container.get_all_descriptions(@item)] : [[], []]
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
    @language          = Language::LOCALE_CODE3[@locale]
    @boost_tree        = Catalog.boost_json(@language)
    @selected_catalogs = Catalog.selected_catalogs(@language)
    @books_catalog     = Catalog.books_catalog(@language).try(:first)
    @search            = Search.new(params[:search])
  end

  def set_independent_parts
    # Надо скрыть в интерфейсе עדכונים נוספים
    # @updated_assets                     = FileAsset.latest_updates(params[:amount_of_updated].to_i > 0 ? params[:amount_of_updated].to_i : 25).includes(:file_asset_descriptions)
    # @available_updated_assets_languages = FileAsset.available_languages(@updated_assets)

    search = Search.new({ date_type: 'one_day', dates_range: (Time.now - 7.days).to_s, per_page: 100 })
    @new_materials = search.search_full_text.results rescue []
    @descriptions = Container.get_all_descriptions(@new_materials)
  end

  def set_virtual_lesson(vl)
    if vl
      @last_lessons = vl.lessons_ordered_by_parts
      @lesson_name  = vl.film_date
      @lesson_id    = vl.id

      @available_languages = FileAsset.insecure.available_languages(@last_lessons.map(&:file_assets).flatten)
      @active_tab          = @available_languages.include?(@locale) ? @locale : @available_languages[0]
    else
      @lesson_date = params[:lesson_date]
    end
  end

end
