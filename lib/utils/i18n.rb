module Utils

  class I18n

    #
    # The method sort the given description according to normal precedence of languages in the system.
    #
    def self.sort_descriptions(descriptions)
      descriptions_main = { }
      descriptions_all = []
      descriptions.each { |x|
        if MAIN_DESCR_LANGS.include? x.lang
          descriptions_main[x.lang] = x
        else
          descriptions_all << x
        end
      }
      MAIN_DESCR_LANGS.map { |d| descriptions_main[d] } + descriptions_all.sort_by { |x| x.lang }
    end

  end

end