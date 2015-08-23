#encoding: utf-8
class FeedsController < ApplicationController

  respond_to :xml

  def wsxml

    # Example
    # wsxml.xml?CID=4016&DLANG=HEB&DF=2013-04-30&DT=2013-03-31

    @language = params[:DLANG] || 'ENG'
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en

    catalog_id = params[:CID] || 25
    date_from = params[:DF] || Date.today.to_s
    date_to = params[:DT] || (Date.today - 30).to_s

    begin
      catalogs = Catalog.where(id: catalog_id).first.all_children_with_root.map(&:id).join(',')
    rescue
      render text: nil
      return
    end

    sql = <<-SQL
      select distinct container.*
      from containers container, catalogs_containers cnl
      where
        container.id = cnl.container_id and
        ( cnl.catalog_id in (#{catalogs})  and
        (container.filmdate BETWEEN '#{date_to}' and '#{date_from}')  and
        container.secure=0 )
      order by container.filmdate desc, created_at desc, name asc
    SQL

    @containers = Container.find_by_sql sql

    @server = "http://#{request.env['HTTP_HOST']}/#{Language::CODE3_LOCALE[@language]}/ui"

    respond_with @containers
  end

  # Script accepts two GET parameters:
  # - DAYS - number of 24-hour periods (1..31 inclusive, default: 1). I.e. 1 means last 24 hours, 2 - last 48 hours etc.
  # - DLANG - 3-letter language abberviation. This is used to select container description only.
  #           Default: ENG
  #
  # If a container has description then in order to be published in RSS it must belong to one the following categories:
  #   3606 - Video
  #   3661 - Audio
  #   3662 - RSS_update
  #
  # If a container has no description it will always be published.

  def rss_video
    @language = params[:DLANG] || 'ENG'
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en

    @days = params[:DAYS].to_i || 1
    @days = 1 if @days > 31 || @days < 1

    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get list of updated files
    @files = FileAsset.get_updated_files(@days).map do |file|
      {
          container_id: file[0],
          title: Container.get_container_title(file[0], @language),
          updated: file[1][0].updated_at,
          files: file[1].group_by { |x| x['ftype'].downcase }
      }
    end.select do |file|
      file[:title]
    end
  end

  def morning_lesson
    @language = params[:DLANG] || 'ENG'
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en

    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get last virtual lesson
    @vl = VirtualLesson.last_lesson
    @lesson_name = @vl.film_date
    @lesson_id = @vl.id
    @containers = @vl.lessons_ordered_by_parts

    render layout: false
  end

  def rss_php
    @language =
        if ['ENG', 'HEB', 'RUS'].include? params[:DLANG]
          params[:DLANG]
        else
          'ENG'
        end
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en
    @lang = params[:DLANG] || 'ENG'
    @title = I18n.t('feed.pod_title')
    @description = I18n.t('feed.pod_description')
    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get list of 20 last containers' files
    results = Container.includes(:file_assets).order('created_at desc').limit(20)

    @files = results.map(&:file_assets).flatten.compact.select { |f| f.asset_type == 'mp3' && f.lang == @language }.flatten.compact.sort { |x, y| y.created_at <=> x.created_at }
    @last_update = results.first.created_at

    render 'rss_php', layout: false
  end

  def podcast
    @language =
        if ['ENG', 'HEB', 'RUS'].include? params[:DLANG]
          params[:DLANG]
        else
          'ENG'
        end
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en
    @lang = params[:DLANG] || 'ENG'
    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get list of 20 last containers' files
    results = Container.podcast.limit(150)

    @files = results.map(&:file_assets).flatten.compact.select { |f| f.asset_type == 'mp3' && f.lang == @language }.flatten.compact.sort { |x, y| y.created_at <=> x.created_at }
    @last_update = results.first.created_at

    @title = 'שיעור הקבלה היומי'
    @podcast = 'podcast'
    @description = 'כאן תקבלו עדכונים יומיים של שיעורי קבלה. התכנים מבוססים על מקורות הקבלה האותנטיים בלבד'
    render 'podcast', layout: false
  end

  def podcast1
    @language =
        if %w(ENG HEB RUS).include? params[:DLANG]
          params[:DLANG]
        else
          'ENG'
        end
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en
    @lang = params[:DLANG] || 'ENG'
    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get list of 20 last containers' files
    results = Catalog.secure(0).podcast1(@lang).first.containers.sort { |a, b| b.created_at <=> a.created_at }[0..150]

    @files = results.map(&:file_assets).flatten.compact.select { |f| f.asset_type == 'mp3' && f.lang == @language }.flatten.compact.sort { |x, y| y.created_at <=> x.created_at }
    @last_update = results.first.created_at

    @title = 'קטע משיעור הקבלה היומי'
    @podcast = 'podcast1'
    @description = 'כאן תקבלו קטעים נבחרים משיעור הקבלה היומי. התכנים מבוססים על מקורות הקבלה האותנטיים בלבד'
    render 'podcast', layout: false
  end

  def google_mapindex
    host = Rails.env.production? ? 'http://kabbalahmedia.info' : "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"
    langs = Language::UI_LANGUAGES

    File.open('public/google_mapindex.xml', 'w+') do |index|
      index.write "<?xml version='1.0' encoding='UTF-8'?>\n"
      index.write "<sitemapindex xmlns='http://www.google.com/schemas/sitemap/0.84' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/siteindex.xsd'>\n"

      fileno = 1
      count = 0
      fz = nil

      Container.uniq.joins(:catalogs).merge(Catalog.insecure).pluck(:id).each do |container|
        langs.each do |lang|
          if count == 0
            filename = "google_sitemap_#{fileno}.xml.gz"
            index.write "<sitemap><loc>#{host}/#{filename}</loc></sitemap>\n"
            fz = Zlib::GzipWriter.open("public/#{filename}", 9)
            fz.write "<?xml version='1.0' encoding='UTF-8'?>\n"
            fz.write "<urlset xmlns='http://www.google.com/schemas/sitemap/0.84' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/siteindex.xsd'>\n"
          end
          fz.write "<url><loc>#{host}/#{lang}/ui/#{container}</loc></url>"
          count += 1

          if count == 49_000
            fz.write "</urlset>\n"
            fz.close
            count = 0
            fileno += 1
          end
        end
      end

      if count != 49_000
        fz.write "</urlset>\n"
        fz.close
      end

      index.write "</sitemapindex>\n"
    end

    if Rails.env.production?
      # ping Google
      open "http://www.google.com/webmasters/tools/ping?sitemap=#{host}/google_mapindex.xml"
      # ping Bing
      open "http://www.bing.com/ping?sitemap=#{host}/google_mapindex.xml"
    end

    render text: 'Done'
  end
end
