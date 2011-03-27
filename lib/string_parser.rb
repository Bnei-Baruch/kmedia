class StringParser
  def initialize(input_str)
    @string = input_str
  end

  def date
    @string[/((19|20)\d\d)-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/]
  end

  def language
    lang = Language.all.map(&:code3).join('|').downcase
    @string[/([^a-z|0-9])(#{lang})([^a-z|0-9])/,2]
  end

end