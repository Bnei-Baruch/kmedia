xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title @title
    xml.link "#{@host}/rss.php"
    xml.tag! 'atom:link', href: "#{@host}rss.php?DLANG=#{@language}", rel: 'self', type: 'application/rss+xml'
    xml.description @description
    xml.language @language
    xml.lastBuildDate @last_update
    xml.ttl @last_update
    xml.copyright { |x| x << "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}" }

    @files.each do |file|
      xml.item do
        container = file.containers.first
        xml.title container_title(container, container_description(container))
        lecturer = container.lecturer
        xml.description "<div>#{lecturer ? "<b>#{t('feed.pod_lecturer')}:</b> #{lecturer.name}" : ''}</div>" +
                            "<div><b>#{t('feed.pod_date')}:</b> #{file.created_at.rfc2822}</div>"
        url = file.url
        xml.link url
        xml.guid url
        xml.pubDate file.created_at.rfc2822

        xml.enclosure url: url, length: file.size, type: 'audio/mpeg'
      end
    end
  end
end
