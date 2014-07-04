module SearchHelper

  def type_of_item(item, size = '-big')
    pattern = item.content_type.try(:pattern)
    pattern = 'program' if pattern == 'magazine'
    pattern = 'image' if pattern == 'graph'
    pattern = 'book' if pattern == 'text'
    "<i class='icon-km#{size}-#{pattern}'></i>".html_safe
  end

  def type_of_item_text(item, cont)
    t("ui.sidebar.type.#{item.content_type.try(:pattern) || 'lesson'}") + cont
  end

  def creation_date(item)
    item.created_at.strftime '%Y-%02m-%02d'
  end

  def film_date(item)
    item.filmdate.try(:strftime, '%Y-%02m-%02d')
  end

  def item_includes(item)
    FileType.map_file_exts_to_types(item.file_assets.map(&:asset_type).uniq).inject('') do |memo, type|
      memo + case type
               when 'text'
                 '<i class="icon-km-small-white-text"></i>&nbsp;'
               when 'video'
                 '<i class="icon-km-small-white-video"></i>&nbsp;'
               when 'audio'
                 '<i class="icon-km-small-white-audio"></i>&nbsp;'
               when 'image', 'graph'
                 '<i class="icon-km-small-white-image"></i>&nbsp;'
               else
                 ''
             end
    end.html_safe
  end

  # Description is pair [long_descr, short_descr]
  def container_title(item, description)
    description.try(:second) || description.try(:first) || item.name
  end

  def container_description(container, descr = @descriptions)
    descriptions = descr ?
        descr[container.id] :
        container.container_descriptions.select{|x| x.id == container.id}
    description_lang = descriptions.select { |d| d.lang == @language }[0]
    description_eng = descriptions.select { |d| d.lang == 'ENG' }[0]

    long_descr = description_lang.try(:descr)
    long_descr_eng = description_eng.try(:descr)
    short_descr = description_lang.try(:container_desc)
    short_descr_eng = description_eng.try(:container_desc)

    [long_descr || long_descr_eng, short_descr || short_descr_eng]
  end

  def file_asset_title(item)
    (item.file_asset_descriptions.select { |d| d.lang == @language } || item.file_asset_descriptions.select { |d| d.lang == 'ENG' }).send(:[], 0).try(:desc) || item.name
  end

  def download_containers(item_file_assets, type, lang, play = false)
    # Find requested language
    lang = Language::LOCALE_CODE3[lang]
    # We'll show file assets as Button group
    file_assets = ''
    # Select only files of requested type (video/audio/text) and language
    item_file_assets.select do |x|
      FileType::EXT_TYPE[x.asset_type.downcase] == type && (x.lang.blank? ? 'ENG' : x.lang) == lang
      # Order by ext and split into chunks according to ext
    end.sort.chunk { |fa| fa.asset_type }.each do |type, files|
      type.upcase!
      file_assets += if files.length == 1
                       # Only one file - show as button
                       fa = files[0]
                       "<div class='btn btn-mini'><a href='#{play ? fa.url : fa.download_url}' #{play ? 'target="_blank"' : nil} title='#{fa.file_asset_descriptions.select { |d| d.lang == lang }.first}'>#{type} #{fa.asset_type}</a></div>"
                     else
                       # Many files - show as dropdown
                       "<div class='btn-group'><div class='btn btn-mini dropdown-toggle' data-toggle='dropdown'><a href='javascript:;'>#{type} <span class='caret'></span></a></div><ul class='dropdown-menu'>" +
                           files.inject('') do |memo, fa|
                             "#{memo}<li><a href='#{play ? fa.url : fa.download_url}' #{play ? 'target="_blank"' : nil} title='#{fa.file_asset_descriptions.select { |d| d.lang == lang }.first}'>#{file_asset_title(fa)} #{fa.asset_type}</a></li>"
                           end +
                           '</ul></div>'
                     end
    end

    file_assets = "<div class='btn-group pull-left'>#{file_assets}</div>" unless file_assets.blank?
    file_assets.html_safe
  end

  def list_items_lang(item, lang, filmed, file_assets = nil)
    # Find requested language
    lang = Language::LOCALE_CODE3[lang]
    # Select only files of requested language
    file_assets = (file_assets || item.file_assets).select do |x|
      (x.lang.blank? ? 'ENG' : x.lang) == lang
    end
    list_items_all(nil, filmed, file_assets)
  end

  def list_items_all(item, filmed, file_assets = nil)
    list = ''
    # Order by ext
    (file_assets || item.file_assets).sort.each do |fa|
      title = fa.name
      descr = fa.file_asset_descriptions.first.try(:filedesc) || fa.name
      size = fa.size.to_f / 1024 / 1024
      playtime = fa.playtime_secs.to_i || item.playtime_secs.to_i
      ext = File.extname(fa.url)[1..10]
      tip = playtime > 0 ?
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % size}Mb&nbsp;|&nbsp;#{Time.at(playtime).utc.strftime('%H:%M:%S')}"
      :
          "#{ext}&nbsp;|&nbsp;#{"%.2f" % size}Mb"

      list += <<-LIST
      <tr>
        <td>
          <table class='inner-table'>
            <tr>
              <td class='left-aligned-column'><a class="block-link" href="#{fa.download_url}" title="#{descr}">#{title}</a></td>
              <td rowspan='2' class="table-buttons hidden-phone"><a class="show-tooltip btn" href="#{fa.download_url}" rel="tooltip" data-animation="true" data-placement="top" title="#{tip}">#{t('ui.updated_assets.download')}</a></td>
              <td rowspan='2' class="table-buttons hidden-phone"><a href="#{fa.url}" title="#{descr}" class='clipboard btn'>#{t('ui.updated_assets.copy_link')}</a></td>
            </tr>
            <tr>
              <td class='left-aligned-column'>
                #{filmed || fa.date.strftime('%Y-%02m-%02d')} | #{fa.asset_type} | #{fa.lang} | #{"%.2f" % size}Mb | #{playtime <= 0 ? '00:00:00' : "#{Time.at(playtime).utc.strftime('%H:%M:%S')}"}
              </td>
            </tr>
          </table>
        </td>
      </tr>
      LIST
    end
    list.html_safe
  end

  def content_type(type, active)
    "<li class='#{active == type ? 'active' : 'x'}'>" +
        "<a class='content-type' href='javascript:;' data-content-type='#{ContentType::CONTENT_TYPE_ID[type]}'>" +
        "<i class='icon-km-#{type}'></i> #{t("ui.sidebar.type.#{type}")}</a>"
  end

  def media_type(type, active)
    "<li class='#{active == type ? 'active' : 'x'}'>" +
        "<a class='media-type' href='javascript:' data-media-type='#{type}'>" +
        "<i class='icon-km-#{type}'></i> #{t("ui.sidebar.type.#{type}")}</a>"
  end
end
