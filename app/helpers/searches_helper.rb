module SearchesHelper
  def languages_to_list
    Language.all.map do |l|
      [l.language, l.code3]
    end
  end

  def content_types_to_list
    ContentType.all.map do |ct|
      [ct.name, ct.id.to_s]
    end
  end

  def file_type_ids_to_list
    FileType.all.map { |ct| [ct.name.humanize, ct.name] }
  end
end
