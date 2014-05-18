module HomeHelper
  def is_active_pager(requested_amount, amount)
    requested_amount.to_i == amount.to_i ? 'active' : 'non-active'
  end

  def list_assets(lesson, locale, exts, type)
    code3 = Language::LOCALE_CODE3[locale]
    extensions = exts.to_a.map { |ext| ".#{ext}" }
    urls = lesson.file_assets.select { |fa| fa.filelang == code3 && extensions.include?(File.extname(fa.filename)) }.map(&:url)
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
    asset = lesson.file_assets.select { |fa| fa.filelang == code3 && File.extname(fa.filename) == extension }.first
    if asset
      download_url = asset.download_url
      filesize = asset.filesize.to_f / 1024 / 1024
      playtime = asset.playtime_secs.to_i || lesson.playtime_secs.to_i
      title = playtime > 0 ?
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % filesize}Mb&nbsp;|&nbsp;#{Time.at(playtime).utc.strftime('%H:%M:%S')}"
      :
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % filesize}Mb"
      <<-CODE
        <a class="btn btn-mini" href="#{download_url}" title="#{title}">#{ext}</a>
      CODE
    else
      ''
    end.html_safe
  end

  def button_asset(lesson, locale, ext)
    code3 = Language::LOCALE_CODE3[locale]
    extension = ".#{ext}"
    asset = lesson.file_assets.select { |fa| fa.filelang == code3 && File.extname(fa.filename) == extension }.first
    asset.try(:url)
  end

  def playlist(last_lessons, language, kind)
    last_lessons.map do |lesson|
      "{#{list_assets(lesson, language, kind == :video ? ['wmv', 'mp4'] : ['mp3'], kind == :video ? 'video/mp4' : 'audio/mpeg')}}"
    end.join(',').html_safe
  end
end
