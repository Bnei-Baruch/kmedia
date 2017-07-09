xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Kabbalah Media Morning Lesson'
    xml.tag! 'atom:link', href: "#{@host}/feeds/rus_for_laitman_ru.rss?DLANG=#{@language}".html_safe, rel: 'self', type: 'application/rss+xml'
    xml.link "#{@host}/rss_video.rss"
    xml.description 'The last lesson from Kabbalamedia Archive'
    xml.language "#{@language}"
    xml.lastBuildDate Time.now.rfc2822
    xml.copyright { |x| x << "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}" }

    xml.item do
      xml.title 'Утренний урок ' + l(@lesson_name)
      xml.guid "#{@host}/#{@language}/ui/#{@lesson_id}?ts=#{Time.now.getutc.to_i}"
      xml.pubDate @vl.created_at.rfc2822
      xml.description do
        description = @containers.inject('') do |description, container|
          description += '<div class="title"><h2>' + container.container_title('RUS') + '</h2>'
          description += 'Видео (рус.): ' + container.show_asset('RUS', 'mp4', false, 'Открыть') + ' | ' + container.show_asset('RUS', 'mp4', true, 'Скачать')
          description += 'Аудио (рус.): ' + container.show_asset('RUS', 'mp3', false, 'Открыть') + ' | ' + container.show_asset('RUS', 'mp3', true, 'Скачать')
          description += 'Видео (ивр.): ' + container.show_asset('HEB', 'mp4', false, 'Открыть') + ' | ' + container.show_asset('HEB', 'mp4', true, 'Скачать')
          description += 'Аудио (ивр.): ' + container.show_asset('HEB', 'mp3', false, 'Открыть') + ' | ' + container.show_asset('HEB', 'mp3', true, 'Скачать')
          description  + '</div>'
        end

        xml.cdata! description.html_safe
      end
    end
  end
end
