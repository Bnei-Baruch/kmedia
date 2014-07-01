xml.instruct!
xml.lessons do
  @lessons.each do |lesson|
    xml.lesson do
      @descriptions = Lesson.get_all_descriptions(lesson)
      xml.title lesson_title(lesson, lesson_description(lesson))
      xml.description @descriptions[lesson.id].select{|d| d.lang == @language}.first.descr
      xml.link "#{@server}/#{lesson.id}"
      xml.date lesson.filmdate.rfc822
      xml.language lesson.lang
      lecturer_name = LecturerDescription.where(id: lesson.id, language: @language).first rescue ''
      xml.lecturer lecturer_name
      xml.files do
        lesson.file_assets.each do |file|
          xml.file do
            xml.type FileType::EXT_TYPE[file.type]
            xml.language file.lang
            xml.original file.lang == lesson.lang ? 1 : 0
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
