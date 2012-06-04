class StringParser
  def initialize(input_str)
    @string = input_str
  end

  def date
    year = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 1]
    month = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 3]
    day = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 4]
    if year.blank? || month.blank? || day.blank?
      raise 'Unable to parse date'
    else
      [year.to_i, month.to_i, day.to_i]
    end
  end

  def language
    lang = Language.all.map(&:code3).join('|').downcase
    @string[/([^a-z0-9])(#{lang})([^a-z0-9])/, 2] || @string[/^(#{lang})([^a-z0-9])/, 1] || raise('Unable to parse language')
  end

  def lecturer_rav?
    @string =~ /^(rav_)|(_rav_)/
  end

  def descriptions
    LessondescPattern.pattern_matches(@string)
  end

  def content_type
    ContentType.all.each do |ct|
      return ct unless @string.scan("_#{ct.pattern}_").blank? && @string.scan("_#{ct.pattern}\.").blank?
    end
    ContentType.find_by_pattern('lesson')
  end

  def content_security_level
    ContentType.all.each do |ct|
      return ct.secure unless @string.scan("_#{ct.pattern}_").blank? && @string.scan("_#{ct.pattern}\.").blank?
    end
    SECURITY.select { |s| s[:name] == 'SuperDuper' }[0][:level]
  end
end