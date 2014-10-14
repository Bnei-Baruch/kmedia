xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', :'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title 'Kabbalah Media Updates'
    xml.tag! 'atom:link', href: "#{@host}/feeds/rss_video.rss?DAYS=#{@days}&DLANG=#{@language}".html_safe, rel: 'self', type: 'application/rss+xml'
    xml.link "#{@host}/rss_video.rss"
    xml.description 'Video updates from Kabbalamedia Archive'
    xml.language "#{@language}"
    xml.lastBuildDate Time.now.rfc2822
    xml.copyright { |x| x << "Bnei-Baruch Copyright 2008-#{Date.today.strftime('%Y')}" }

    @files.each do |file|
      xml.item do
        xml.title file[:title]
        xml.guid "#{@host}/#{@locale}/ui/#{file[:container_id]}"
        xml.pubDate file[:updated].rfc2822
        xml.description do
          items = ''
          file[:files].keys.each do |key|
            items += case key.downcase
                       when 'doc'
                         '<b>Texts:</b><br/>'
                       when 'jpg', 'bmp', 'jpeg', 'gif', 'png'
                         '<b>Pictures:</b><br/>'
                       when 'pdf'
                         '<b>PDFs:</b><br/>'
                       when 'wmv'
                         '<b>Video-wmv:</b><br/>'
                       when 'mp3'
                         '<b>Audio:</b><br/>'
                       when 'mp4'
                         '<b>Video-mp4:</b><br/>'
                       when 'flv'
                         '<b>Flash:</b><br/>'
                       else
                         '<b>Other:</b><br/>'
                     end

            file[:files][key].each do |item|
              filesize = number_to_human_size(item.fsize.to_f, locale: :en, presision: 3, strip_insignificant_zeros: false).sub(' ', '')
              name = case key.downcase
                       when 'jpg', 'bmp', 'jpeg', 'gif', 'png'
                         "#{item[:ftype].upcase}_#{filesize}"
                       else
                         "#{item[:flang]}_#{filesize}"
                     end
              items += "<div><a href='#{item[:link]}'>#{name}</a></div>"
            end
          end
          xml.cdata! items
        end
      end
    end
  end
end
