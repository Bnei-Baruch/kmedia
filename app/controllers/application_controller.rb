class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mailer_set_url_options
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
    sort_column + " " + sort_direction
  end

  def default_sort_column
    "id"
  end

  def default_sort_direction
    "desc"
  end
end
