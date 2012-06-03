class FileTypesController < ApplicationController

  # List of file types
  #
  # { "list_of_file_types": {
  #     "auth_token":"<authentication-token>"
  #   }
  # }
  #
  # Response:
  # {
  #   "file_types":
  #     [
  #       {
  #         "name":"graph",
  #         "extensions":['jpg','gif','zip'],
  #         "pic":'images/picture.gif',
  #       },
  #       ...
  #     ]
  # }

  def index
    @file_types = FileType.all
  end
end
