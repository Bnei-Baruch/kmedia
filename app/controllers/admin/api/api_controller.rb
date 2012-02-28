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
  # Request header: Content-Type: application.json
  # Request Body  :
  # {
  #   "auth_token":"<authentication-token>",
  #   "container":"<name-of-container>"
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
  # @param file - name of file
  # @param server - name of server (Default: FILES-EU)
  # @param time - time of modification of a file (mtime)
  # @param size - size of the file in bytes
  def register_file
    container = params[:container]
    result = begin
      Lesson.add_update(container, params[:files])
      {message: "Success", code: true}
    rescue Exception => e
      {message: "Exception: #{e.message}", code: false}
    end

    render :json => result
  end

  # Return server name that a given file resides on
  #
  # Request header: Content-Type: application.json
  # Request Body  :
  # {
  #   "auth_token":"<authentication-token>",
  #   "filename" : "<name-of-file>"
  # }
  # @param filename - name of a file to return a Server of
  #
  # @returns {"server":"FILES-EU"}
  def get_file_servers
    filename = params[:filename] || ''
    file = FileAsset.find_by_filename(filename)
    server = {server: (file.try(:servername) || DEFAULT_FILE_SERVER)}
    render json: server.to_json
  end

end
