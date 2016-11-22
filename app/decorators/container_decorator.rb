class ContainerDecorator < Draper::Decorator
  delegate_all

  def show_asset(locale, ext, name = nil)
    code3 = Language::LOCALE_CODE3[locale]
    extensions = ext.split('|').map{|x| ".#{x}"}
    asset = file_assets.select { |fa| (locale ? fa.lang == code3 : true) && extensions.include?(File.extname(fa.name))  && fa.name =~ /^((?!kitei-makor).)*$/ }.first
    return '' unless asset

    size = asset.size.to_f / 1024 / 1024
    playtime = asset.playtime_secs.to_i || container.playtime_secs.to_i
    title = playtime > 0 ?
        "#{ext}&nbsp;|&nbsp;#{"%.2f" % size}Mb&nbsp;|&nbsp;#{Time.at(playtime).utc.strftime('%H:%M:%S')}"
    :
        "#{ext}&nbsp;|&nbsp;#{"%.2f" % size}Mb"
    result = <<-CODE
      <a class="btn btn-mini" href="#{asset.download_url}" title="#{title}">#{name || ext}</a>
    CODE
    result.html_safe
  end

  def list_assets(locale, exts, type)
    code3 = Language::LOCALE_CODE3[locale]
    extensions = exts.to_a.map { |ext| ".#{ext}" }
    urls = file_assets.select { |fa| fa.lang == code3 && extensions.include?(File.extname(fa.name)) }.map(&:url)
    index = 0
    urls.inject([]) do |sum, url|
      sum << "#{index}: {src: '#{url}', type: '#{type}'}"
      index += 1
      sum
    end.join(',')
  end

end
