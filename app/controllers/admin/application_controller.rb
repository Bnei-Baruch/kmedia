class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

end
