xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Kabbalah Media Morning Lesson'
    xml.tag! 'atom:link', href: "#{@host}/feeds/morning_lesson.rss?DLANG=#{@language}".html_safe, rel: 'self', type: 'application/rss+xml'
    xml.link "#{@host}/rss_video.rss"
    xml.description 'The last lesson from Kabbalamedia Archive'
    xml.language "#{@language}"
    xml.lastBuildDate Time.now.rfc2822
    xml.copyright { |x| x << "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}" }

    xml.item do
      xml.title I18n.t('ui.last_lesson.lesson') + ' ' + I18n.t('ui.last_lesson.lesson_from') + ' ' + l(@lesson_name)
      xml.guid "#{@host}/#{@language}/ui/#{@lesson_id}?ts=#{Time.now.getutc.to_i}"
      xml.pubDate @vl.updated_at.rfc2822
      xml.description do

        description = @containers.inject('') do |description, container|
          description += container.container_title(@language) + '<br/>'
          description += container.show_asset(@language, 'mp4', false, t('ui.last_lesson.video', locale: @locale) + ' mp4') + '<br/>'
          description += container.show_asset(@language, 'mp3', false, t('ui.last_lesson.audio', locale: @locale) + ' mp3') + '<br/>'
          description += container.show_asset(@language, 'doc') + '<br/>'
          pic         = container.show_asset(@language, 'zip|7z', false, 'pic') + '<br/>'
          description += pic.blank? ? container.show_asset(nil, 'zip|7z', false, 'pic') + '<br/>' : pic + '<br/>'
          description += container.show_asset(@language, 'wmv') + '<br/>'
        end
        listen = '<h4>' + t('ui.last_lesson.playlist') + '</h4>' + description

        description = @containers.inject('') do |description, container|
          description += container.container_title(@language) + '<br/>'
          description += container.show_asset(@language, 'mp4', true, t('ui.last_lesson.video', locale: @locale) + ' mp4') + '<br/>'
          description += container.show_asset(@language, 'mp3', true, t('ui.last_lesson.audio', locale: @locale) + ' mp3') + '<br/>'
          description += container.show_asset(@language, 'doc', true) + '<br/>'
          pic = container.show_asset(@language, 'zip|7z', true, 'pic') + '<br/>'
          description += pic.blank? ? container.show_asset(nil, 'zip|7z', true, 'pic') + '<br/>' : pic + '<br/>'
          description += container.show_asset(@language, 'wmv', true) + '<br/>'
        end
        download = '<h4>' + t('ui.last_lesson.download') + '</h4>' + description

        xml.cdata! (listen + download).html_safe
      end
    end
  end
end
