xml.instruct!
xml.lessons do
  @lessons.each do |container|
    xml.lesson do
      @descriptions = Container.get_all_descriptions(container)
      xml.title container_title(container, container_description(container))
      xml.description @descriptions[container.id].select{|d| d.lang == @language}.first.descr
      xml.link "#{@server}/#{container.id}"
      xml.date container.filmdate.rfc822
      xml.language container.lang
      lecturer_name = LecturerDescription.where(id: container.id, language: @language).first rescue ''
      xml.lecturer lecturer_name
      xml.files do
        container.file_assets.each do |file|
          xml.file do
            xml.type FileType::EXT_TYPE[file.type]
            xml.language file.lang
            xml.original file.lang == container.lang ? 1 : 0
            xml.path file.url
            size = number_to_human_size(file.size, locale: :en)
            xml.size size
            playtime = file.playtime_secs.to_i
            xml.length playtime > 0 ? Time.at(playtime).utc.strftime('%H:%M:%S') : '?'
            xml.title "#{file.lang} #{size}"
          end
        end
      end
    end
  end
end
