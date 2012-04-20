class Admin::Api::ApiController < Admin::ApplicationController


  # In order to get any service you have to authenticate via
  # POST /admin/api/tokens.json with email and password in body


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

    render json:
               begin
                 Lesson.add_update(params[:container], params[:files], params[:dry_run] == 'true')
                 { message: "Success", code: true }
               rescue Exception => e
                 message = "Exception: #{e.message}\n\n\tBacktrace: #{e.backtrace.join("\n\t")}"
                 logger.error "#{message}\n\n\tParams: #{params.inspect}"
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

end
