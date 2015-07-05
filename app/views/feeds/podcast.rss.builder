xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom', 'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title 'שיעור הקבלה היומי'
    xml.link "#{@host}/feeds/podcast?DLANG=#{@language}"
    xml.tag! 'atom:link', href: "#{@host}/feeds/podcast?DLANG=#{@language}", rel: 'self', type: 'application/rss+xml'
    xml.tag! 'itunes:category', text: 'Spirituality'
    xml.tag! 'itunes:image', href: "#{host}/images/cover170x170.jpeg"
    xml.description 'כאן תקבלו עדכונים יומיים של שיעורי קבלה. התכנים מבוססים על מקורות הקבלה האותנטיים בלבד'
    xml.author 'קבלה לעם'
    xml.language @language
    xml.lastBuildDate @last_update
    xml.ttl @last_update
    xml.copyright "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}"

    @files.each do |file|
      xml.item do
        container = file.containers.first

        filmed = film_date(container)
        long_description, short_description = container_description(container)
        description = long_description.blank? ? short_description : long_description
        title = "#{container_title(file,  [nil, short_description])} (#{filmed})"

        xml.author 'קבלה לעם'
        xml.title title
        xml.description container_title(container, container_description(container))
        url = file.url
        xml.link url
        xml.guid url
        xml.pubDate file.created_at.rfc2822

        xml.enclosure url: url, length: file.size, type: 'audio/mpeg'
      end
    end
  end
end
