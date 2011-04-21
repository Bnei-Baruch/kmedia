class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
