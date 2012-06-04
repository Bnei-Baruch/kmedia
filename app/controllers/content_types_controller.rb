class ContentTypesController < ApplicationController
  before_filter :check_permissions

  # List of content types
  #
  # Request:
  #  "auth_token":"<authentication-token>"
  #  "secure":[<integer1>, <integer2>,...], -- optional, default: according to user (PSearch - >= 0, Search - 0)
  #
  # Response:
  # {
  #   "content_types":
  #     [
  #       {
  #         "id": 13,
  #         "name": "Declamation",
  #         "pattern": "declamation",
  #         "secure": 0
  #       },
  #       ...
  #     ]
  # }

  def index
    @content_types = ContentType.where("secure <= ?", @secure)
  end

  private

  def check_permissions
    @secure = can?(:search_secure, :catalogs) ? params[:secure].to_i : 0
  end
end
