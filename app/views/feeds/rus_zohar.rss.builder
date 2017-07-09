xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Kabbalah Media Zohar Lesson'
    xml.tag! 'atom:link', href: "#{@host}/feeds/rus_zohar.rss?DLANG=#{@language}".html_safe, rel: 'self', type: 'application/rss+xml'
    xml.link "#{@host}/rss_video.rss"
    xml.description 'The evening Zohar lesson from Kabbalahmedia Archive'
    xml.language "#{@language}"
    xml.lastBuildDate Time.now.rfc2822
    xml.copyright "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}"

    xml.item do
      xml.title "Урок по Книге Зоар, #{@container.created_at.strftime('%d.%m.%Y')}"
      xml.guid "#{@host}/#{@language}/ui/#{@lesson_id}?ts=#{Time.now.getutc.to_i}"
      xml.pubDate @container.created_at.rfc2822
      xml.description do
        description = '<div class="title"><h2>' + @container.container_title('RUS') + '</h2>' +
          'Видео (рус.): ' + @container.show_asset('RUS', 'mp4', false, 'Открыть') + ' | ' + @container.show_asset('RUS', 'mp4', true, 'Скачать') +
          'Аудио (рус.): ' + @container.show_asset('RUS', 'mp3', false, 'Открыть') + ' | ' + @container.show_asset('RUS', 'mp3', true, 'Скачать') +
          'Видео (ивр.): ' + @container.show_asset('HEB', 'mp4', false, 'Открыть') + ' | ' + @container.show_asset('HEB', 'mp4', true, 'Скачать') +
          'Аудио (ивр.): ' + @container.show_asset('HEB', 'mp3', false, 'Открыть') + ' | ' + @container.show_asset('HEB', 'mp3', true, 'Скачать') +
          '</div>'

        xml.cdata! description.html_safe
      end
    end
  end
end
