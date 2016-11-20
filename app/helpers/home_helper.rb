module HomeHelper
  def is_active_pager(requested_amount, amount)
    requested_amount.to_i == amount.to_i ? 'active' : 'non-active'
  end

  def show_asset(container, locale, ext, name = nil, pattern = /.*/)
    code3      = Language::LOCALE_CODE3[locale]
    extensions = ext.split('|').map { |x| ".#{x}" }
    name       ||= ext
    asset      = container.file_assets.select { |fa| (locale ? fa.lang == code3 : true) && extensions.include?(File.extname(fa.name)) && fa.name =~ pattern }.first
    if asset
      download_url = asset.download_url
      size         = asset.size.to_f / 1024 / 1024
      playtime     = asset.playtime_secs.to_i || container.playtime_secs.to_i
      title        = playtime > 0 ?
          "#{ext}&nbsp;|&nbsp;#{'%.2f' % size}Mb&nbsp;|&nbsp;#{Time.at(playtime).utc.strftime('%H:%M:%S')}"
      :
          "#{ext}&nbsp;|&nbsp;#{'%.2f' % size}Mb"
      <<-CODE
        <a class="btn btn-mini" href="#{download_url}" title="#{title}">#{name}</a>
      CODE
    else
      ''
    end.html_safe
  end

  def button_asset(container, locale, ext)
    code3     = Language::LOCALE_CODE3[locale]
    extension = ".#{ext}"
    asset     = container.file_assets.select { |fa| fa.lang == code3 && File.extname(fa.name) == extension }.first
    asset.try(:url)
  end

  def playlist(last_containers, language, kind)
    code3     = Language::LOCALE_CODE3[language]
    extension = kind == :video ? '.mp4' : '.mp3'
    type      = kind == :video ? 'video/mp4' : 'audio/mpeg'
    last_containers.map do |container|
      asset = container.file_assets.select { |fa| fa.lang == code3 && extension == File.extname(fa.name) }.first
      next if asset.nil?

      description = container_title(container, container_description(container, Container.get_all_descriptions(container), code3))
      "{description: '#{j description}', time: '#{asset.playtime_human}', date: '#{container.created_at.to_date}', sources: [{file: '#{asset.url}', type: '#{type}'}], image: '/assets/cover-video.jpg'}"
    end.compact.join(',').html_safe
  end
end
