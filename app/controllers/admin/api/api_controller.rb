class Admin::Api::ApiController < Admin::ApplicationController
  before_filter :check_permissions

  # In order to get any service you have to authenticate via
  # POST /admin/api/tokens.json with email and password in body


  ###############################################################################################################
  # Privileged Search User -- may select secure > 0
  ###############################################################################################################

  # Search
  #
  # Request:
  # { "search": {
  #     "auth_token":"<authentication-token>"
  #     "query_text": <string>, -- free text search
  #     "secure": [<integer>, ...], -- default: 0
  #     "content_types": [<integer>, ...], -- ids of content types
  #     "file_languages": [<integer>, ...], -- ids of languages
  #     "media_types": [<integer>, ...], -- ids of media types
  #     "catalogs": [<integer>, ...], -- ids of catalogs
  #     "date_from": <datetime>, -- optional
  #     "date_to": <datetime>, -- optional
  #     "series":[<string>, ...], -- optional
  #   }
  # }
  #
  # Response:
  # {
  #   "files":
  #     [
  #       {
  #         "id": <integer>,
  #         "name": <string>,
  #         "lang": <string>,
  #         "filetype": <string>,
  #         "record_date": <datetime>,
  #         "size": <integer>,
  #         "url": <string>,
  #         "created": <datetime>,
  #         "updated": <datetime>,
  #         "secure": <integer>
  #       }
  #       ...
  #     ]
  # }


  ###############################################################################################################
  # API User -- creation of containers
  ###############################################################################################################


  # Register file(s) into a container.
  #
  # Both file(s) and container may exist and will be updated.
  # The file(s) will be assigned to container.
  # Non-existing file descriptions, according fo file extension + _96k,
  # will be updated - filedesc (fileid,lang,filedesc)
  #
  # The following tables/fields will be updated automatically:
  # container:  date, language, lecturer (if rav), container type, descriptions
  #
  # If 'dry_run' is true - nothing will be created, just a validations will be performed
  #
  # Request header: Content-Type: application.json
  # Request Body  :
  # {
  #   "auth_token":"<authentication-token>",
  #   "container":"<name-of-container>"
  #   "dry_run" : true/false,
  #   "files" : [
  #     {
  #       "file" : "<name-of-file>",
  #       "server" : "<name-of-server>",
  #       "time" : "filemtime",
  #       "size" : <size-of-file>
  #     },
  #     ...
  #   ]
  # }
  # @param container - name of container (directory)
  # @param dry_run - (default: false) perform just validations
  # @param files - list of files to add to this container
  #   Each file has the following format:
  #   @param file - name of file
  #   @param server - name of server (Default: FILES-EU)
  #   @param time - time of modification of a file (mtime)
  #   @param size - size of the file in bytes
  def register_file

    # only APIUser is permitted to use API
    api_role = Role.find_by_name('APIUser')

    unless current_user.roles.include? api_role
      logger.info("User #{email} is not an API user.")
      render :status => 401, :json => { :message => "Not an API user.", code: false }
      return
    end

    render json:
               begin
                 Lesson.add_update(params[:container], params[:files], params[:dry_run] || params[:dry_run] == 'true')
                 { message: "Success", code: true }
               rescue Exception => e
                 message = "Exception: #{e.message}\n\n\tBacktrace: #{e.backtrace.join("\n\t")}"
                 logger.error "#{message}\n\n\tParams: #{params.inspect}"
                 ExceptionNotifier::Notifier.exception_notification(request.env, e).deliver if Rails.env.production?
                 { message: message, code: false }
               end
  end

  # Return server name that a given file resides on or default server if file was not found
  # As well field 'found' returns presence of file
  #
  # Request header: Content-Type: application.json
  # Request Body  :
  # {
  #   "auth_token":"<authentication-token>",
  #   "filename" : "<name-of-file>"
  # }
  # @param filename - name of a file to return a Server of
  #
  # @returns {found: true, "server":"VIDEO-EU"}
  # @returns {found: true, "server":"FILES-EU"}
  def get_file_servers
    file = FileAsset.find_by_filename(params[:filename] || '')
    render json: { found: !file.nil?, server: (file.try(:servername) || DEFAULT_FILE_SERVER) }
  end

  # List of catalogs
  #
  # Request:
  #  "auth_token":"<authentication-token>",
  #  "locale": <string> -- optional, default 'en' (English)
  #  "secure":[<integer1>], -- optional, default: 0
  #  "root": <integer>,
  #
  # Response:
  # {
  #   "catalogs":
  #     [
  #       {
  #         "name":"r1",
  #         "text":"r1",
  #         "id":10,
  #         "order":2,
  #         "secure":1,
  #         "has_children": true/false
  #       },
  #       ...
  #     ]
  # }
  def catalogs
    # map locale to code3
    @language = Language.find_by_locale(params[:locale] || 'en').try(:code3) || 'ENG'

    @root = Catalog.secure(@secure).where(:catalognodeid => params[:root]).first
    @catalogs = @root.children
  end

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

  def content_types
    @content_types = ContentType.where("secure <= ?", @secure)
  end

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

  def file_types
    @file_types = FileType.all
  end

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

  def languages
    @languages = Language.all
  end

  private

  def check_permissions
    # Check whether specific user is permitted to change security level
    @secure = can?(:search_secure, :catalogs) ? params[:secure].to_i : 0
  end

end
