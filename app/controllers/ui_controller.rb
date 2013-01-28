class UiController < ApplicationController

  before_filter :setup

  # Homepage
  def homepage
    @last_virtual_lesson, @prev_lesson, @next_lesson = VirtualLesson.last_lesson(params[:before_lesson], params[:after_lesson])
    @last_lessons = @last_virtual_lesson.lessons
    @available_last_lessons_languages = FileAsset.available_languages(@last_lessons)
    @updated_assets = FileAsset.latest_updates(params[:amount_of_updated].to_i > 0 ? params[:amount_of_updated].to_i : 25)
    @available_updated_assets_languages = FileAsset.available_languages(@updated_assets)
  end

  # Search result
  def index
    search params
  end

  # Show specific item page
  def show
    @item = Lesson.find params[:id]
    @available_languages = FileAsset.available_languages(@item.file_assets)
  end

  private

  def setup
    @language = Language.find_by_locale(:en).code3
  end

  def search(params)
    @search = Search.new(params[:search])
    @active_content_type = @search.content_type_id.blank? ? 'all' : ContentType.find(@search.content_type_id).pattern
    @active_media_type = @search.media_type_id.blank? ? 'all' : @search.media_type_id
    @active_date_type = @search.date_type.blank? ? 'anytime' : @search.date_type
    @dates_range = @search.dates_range
    @date_type = @search.date_type
    @language_ids = @search.language_ids
    @results = @search.search_full_text params[:page]
  end
end
