class LanguagesController < ApplicationController

  # List of languages
  #
  # Request:
  # { "list_of_languages": {
  #     "auth_token":"<authentication-token>"
  #   }
  # }
  #
  # Response:
  # {
  #   "languages":
  #     [
  #       {
  #         "id": 1,
  #         "locale": "en",
  #         "code3": "ENG",
  #         "language": "English"
  #       },
  #       ...
  #     ]
  # }

  def index
    @languages = Language.all
  end
end
