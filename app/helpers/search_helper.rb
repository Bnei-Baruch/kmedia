module SearchHelper

  def type_of_item(item)
    pattern = item.content_type.try(:pattern)
    pattern = 'program' if pattern == 'magazine'
    pattern = 'image' if pattern == 'graph'
    "<i class='icon-km-big-#{pattern}'></i>".html_safe
  end

  def type_of_item_text(item, cont)
    t("ui.sidebar.type.#{item.content_type.try(:pattern)}") + cont
  end

  def creation_date(item)
    item.created.strftime '%Y-%02m-%02d'
  end

  def item_includes(item)
    FileType.map_file_exts_to_types(item.file_assets.map(&:filetype).uniq).inject('') do |memo, type|
      memo + case type
               when 'text'
                 '<i class="icon-km-small-white-text"></i>&nbsp;'
               when 'video'
                 '<i class="icon-km-small-white-video"></i>&nbsp;'
               when 'audio'
                 '<i class="icon-km-small-white-audio"></i>&nbsp;'
               when 'magazine', 'program'
                 '<i class="icon-km-small-white-program"></i>&nbsp;'
               when 'image', 'graph'
                 '<i class="icon-km-small-white-image"></i>&nbsp;'
               else
                 ''
             end
    end.html_safe
  end

  def lesson_title(item, description)
    description || item.lessonname
  end

  def lesson_description(item)
    (item.lesson_descriptions.select { |d| d.lang == @language } || item.lesson_descriptions.select { |d| d.lang == 'ENG' }).send(:[], 0).try(:lessondesc)
  end

  def file_asset_title(item)
    (item.file_asset_descriptions.select { |d| d.lang == @language } || item.file_asset_descriptions.select { |d| d.lang == 'ENG' }).send(:[], 0).try(:filedesc) || item.filename
  end

  def download_items(item, type, lang, play = false)
    # Find requested language
    lang = Language::LOCALE_CODE3[lang]
    # We'll show file assets as Button group
    file_assets = '<div class="btn-group pull-left">'
    # Select only files of requested type (video/audio/text) and language
    item.file_assets.select do |x|
      FileType::EXT_TYPE[x.filetype.downcase] == type && (x.filelang.blank? ? 'ENG' : x.filelang) == lang
      # Order by ext and split into chunks according to ext
    end.sort.chunk { |fa| fa.filetype }.each do |filetype, files|
      filetype.upcase!
      file_assets += if files.length == 1
                       # Only one file - show as button
                       fa = files[0]
                       "<button class='btn btn-mini'><a href='#{play ? fa.url : fa.download_url}' #{play ? 'target="_blank"' : nil} title='#{fa.file_asset_descriptions.select { |d| d.lang == lang }.first}'>#{filetype}</a></button>"
                     else
                       # Many files - show as dropdown
                       "<button class='btn btn-mini dropdown-toggle' data-toggle='dropdown'><a href='javascript:;'>#{filetype} <span class='caret'></span></a></button><ul class='dropdown-menu'>" +
                           files.inject('') do |memo, fa|
                             "#{memo}<li><a href='#{play ? fa.url : fa.download_url}' #{play ? 'target="_blank"' : nil} title='#{fa.file_asset_descriptions.select { |d| d.lang == lang }.first}'>#{file_asset_title(fa)}</a></li>"
                           end +
                           '</ul>'
                     end
    end

    file_assets += '</div>'
    file_assets.html_safe
  end

  def list_items_lang(item, lang, file_assets = nil)
    # Find requested language
    lang = Language::LOCALE_CODE3[lang]
    # Select only files of requested language
    file_assets = (file_assets || item.file_assets).select do |x|
      (x.filelang.blank? ? 'ENG' : x.filelang) == lang
    end
    list_items_all(nil, file_assets)
  end

  def list_items_all(item, file_assets = nil)
    list = ''
    # Order by ext
    (file_assets || item.file_assets).sort.each do |fa|
      title = fa.file_asset_descriptions.first.try(:filedesc) || fa.filename
      filesize = fa.filesize.to_f / 1024 / 1024
      playtime = fa.playtime_secs.to_i

      list += <<-LIST
      <tr>
        <td class='left-aligned-column'>#{fa.filedate.strftime '%Y-%02m-%02d'}</td>
        <td class='left-aligned-column download-url'>
          <a href='#{fa.download_url}' title='#{title}'>#{title}</a>
        </td>
        <td>#{fa.filetype}</td>
        <td>#{fa.filelang}</td>
        <td><a href='#{fa.download_url}' title='#{title}' class='download'><i class='icon-download'></i></a></td>
        <td><a href='#{fa.url}' title='#{title}' class='clipboard'><i class='icon-circle-arrow-right'></i></a></td>
        <td>#{"%.2f" % filesize}Mb</td>
        <td>#{playtime <= 0 ? '00:00:00' : "#{Time.at(playtime).utc.strftime('%H:%M:%S')}"}</td>
      </tr>
      LIST
    end
    list.html_safe
  end

  def content_type(type, active)
    "<li class='#{active == type ? 'active' : 'x'}'>" +
        "<a href='javascript:' onclick='return content_type(\"#{ContentType.find_by_pattern(type).try(:id)}\");'>" +
        "<i class='icon-km-#{type}'></i> #{t("ui.sidebar.type.#{type}")}</a>"
  end

  def media_type(type, active)
    "<li class='#{active == type ? 'active' : 'x'}'>" +
        "<a href='javascript:' onclick='return media_type(\"#{type}\");'>" +
        "<i class='icon-km-#{type}'></i> #{t("ui.sidebar.type.#{type}")}</a>"
  end
end
