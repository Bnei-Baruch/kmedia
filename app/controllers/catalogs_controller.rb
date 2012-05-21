class CatalogsController < ApplicationController
  before_filter :check_permissions

  # List of catalogs
  #
  # Request:
  #  "auth_token":"<authentication-token>",
  #  "locale": <string> -- optional, default 'en' (English)
  #  "secure":[<integer1>, <integer2>,...], -- optional, default: according to user (PSearch - >= 0, Search - 0)
  #  "parent": <node id> -- optional, default: 0 - topmost categories
  #
  # Response:
  # {
  #   "catalogs":
  #     [
  #       {
  #         "name":"r1",
  #         "id":10,
  #         "order":2,
  #         "secure":1,
  #         "has_children": true/false
  #       },
  #       ...
  #     ]
  # }
  def index
    parent = params[:root]
    # map locale to code3
    @language = Language.find_by_locale(params[:locale] || 'en').try(:code3) || 'ENG'

    # start from parent
    @catalogs = get_catalogs(parent, @secure, @language)
    get_children(@catalogs, @secure, @language)
  end

  private
  def get_catalogs(parent, secure, language)
    parent = (parent.blank? || parent == 0 || parent == '0') ? nil : parent
    Catalog.where(:parentnodeid => parent).where("secure <= ?", secure)
  end

  def get_children(catalogs, secure, language)
    catalogs.each {|catalog|
      catalog.has_children = ! get_catalogs(catalog.id, secure, language).empty?
    }
  end

  def check_permissions
    @secure = can?(:search_secure, :catalogs) ? params[:secure].to_i : 0
  end
end
