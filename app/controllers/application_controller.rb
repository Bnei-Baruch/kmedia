class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :mailer_set_url_options
  before_filter :set_data

  helper_method :sort_direction, :sort_column

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : default_sort_direction
  end

  def sort_column
    params[:sort] || default_sort_column
  end

  def sort_order
    sort_column + ' ' + sort_direction
  end

  def default_sort_column
    'id'
  end

  def default_sort_direction
    'desc'
  end

  # For any url_for (except devise)
  def default_url_options(options={})
    {:locale => (params[:locale] || I18n.locale)}
  end

  # Devise plugin only
  def self.default_url_options(options={})
    {:locale => I18n.locale}
  end

  private

  def set_data
    I18n.locale = @locale = params[:locale] || cookies[:kmedia_locale] || 'en'
    cookies.permanent[:kmedia_locale] = @locale
    @menu_languages = Language.menu_languages(Language::UI_LANGUAGES).map{|x| [x['language'], root_url(x['locale'])]}
    @current_menu_language = root_url(@locale)

    @comment_data = Comment.new
  end

end
