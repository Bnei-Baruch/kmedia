class Language < ActiveRecord::Base
  def lang_name
    "#{language} (#{code3})"
  end
end
