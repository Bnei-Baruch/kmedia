module HomeHelper
  def is_active_pager(requested_amount, amount)
    requested_amount.to_i == amount.to_i ? 'active' : 'non-active'
  end

  def lesson_part(lesson, language = 'en')
    language = Language::LOCALE_CODE3[language]
    ids = lesson.catalogs.map(&:id)
    case
      when ids.include?(Lesson::PREPARATION)
        I18n.t('ui.last_lesson.preparation')
      when ids.include?(Lesson::FIRST_PART)
        I18n.t('ui.last_lesson.first_part')
      when ids.include?(Lesson::SECOND_PART)
        I18n.t('ui.last_lesson.second_part')
      when ids.include?(Lesson::THIRD_PART)
        I18n.t('ui.last_lesson.third_part')
      when ids.include?(Lesson::FOURTH_PART)
        I18n.t('ui.last_lesson.fourth_part')
      when ids.include?(Lesson::FIFTH_PART)
        I18n.t('ui.last_lesson.fifth_part')
      else
        I18n.t('ui.last_lesson.first_part')
    end
  end

  def list_assets(lesson, locale, exts, type)
    code3 = Language::LOCALE_CODE3[locale]
    extensions = exts.to_a.map{|ext| ".#{ext}" }
    urls = lesson.file_assets.select{|fa| fa.filelang == code3 && extensions.include?(File.extname(fa.filename))}.map(&:url)
    index = 0
    urls.inject([]) do |sum, url|
      sum << "#{index}: {src: '#{url}', type: '#{type}'}"
      index += 1
      sum
    end.join(',')
  end

  def show_asset(lesson, locale, ext)
    code3 = Language::LOCALE_CODE3[locale]
    extension = ".#{ext}"
    asset = lesson.file_assets.select{|fa| fa.filelang == code3 && File.extname(fa.filename) == extension}.first
    if asset
      download_url = asset.download_url
      filesize = asset.filesize.to_f / 1024 / 1024
      playtime = asset.playtime_secs.to_i || lesson.playtime_secs.to_i
      title = playtime > 0 ?
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % filesize}Mb&nbsp;|&nbsp;#{Time.at(playtime).utc.strftime('%H:%M:%S')}"
      :
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % filesize}Mb"
      <<-CODE
        <a class="show-tooltip" href="#{download_url}" rel="tooltip" data-animation="true" data-placement="top" title="#{title}">
          <i class="icon-download"></i>
        </a>
      CODE
    else
      '&nbsp;'
    end.html_safe
  end

  def button_asset(lesson, locale, ext)
    code3 = Language::LOCALE_CODE3[locale]
    extension = ".#{ext}"
    asset = lesson.file_assets.select{|fa| fa.filelang == code3 && File.extname(fa.filename) == extension}.first
    asset.try(:url)
  end
end
