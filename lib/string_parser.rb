class StringParser
  def initialize(input_str)
    @string = input_str
  end

  def date
    year = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 1]
    month = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 3]
    day = @string[/((19|20)\d\d)-(0?[1-9]|1[012])-([^a-z0-9][1-9]|0[1-9]|[12][0-9]|3[01])/, 4]
    [year.to_i, month.to_i, day.to_i]
  end

  def language
    lang = Language.all.map(&:code3).join('|').downcase
    @string[/([^a-z0-9])(#{lang})([^a-z0-9])/,2]
  end

  def lecturer_rav?
    @string =~ /^(rav_)|(_rav_)/
  end

  def descriptions
    LessondescPattern.pattern_matches(@string)
  end
end