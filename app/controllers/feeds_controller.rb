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

    catalogs = Catalog.where(catalognodeid: catalog_id).first.all_children_with_root.map(&:id).join(',')

    sql = <<-SQL
      select distinct lesson.*
      from lessons lesson, catnodelessons cnl
      where
        lesson.lessonid = cnl.lessonid and
        ( cnl.catalognodeid in (#{catalogs})  and
        (lesson.lessondate BETWEEN '#{date_to}' and '#{date_from}')  and
        lesson.secure=0 )
      order by lesson.lessondate desc, created desc, lessonname asc
    SQL

    @lessons = Lesson.find_by_sql sql

    @server = "http://#{request.env['HTTP_HOST']}/#{Language::CODE3_LOCALE[@language]}/ui"

    respond_with @lessons
  end

  # Script accepts two GET parameters:
  # - DAYS - number of 24-hour periods (1..31 inclusive, default: 1). I.e. 1 means last 24 hours, 2 - last 48 hours etc.
  # - DLANG - 3-letter language abberviation. This is used to select lesson description only.
  #           Default: ENG
  #
  # If a lesson has description then in order to be published in RSS it must belong to one the following categories:
  #   3606 - Video
  #   3661 - Audio
  #   3662 - RSS_update
  #
  # If a lesson has no description it will always be published.

  def rss_video
    @language = params[:DLANG] || 'ENG'
    I18n.locale = @locale = Language::CODE3_LOCALE[@language] || :en

    @days = params[:DAYS].to_i || 1
    @days = 1 if @days > 31 || @days < 1

    @host = "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ":#{request.port}"}"

    # Get list of updated files
    @files = get_updated_files(@days).map do |file|
      {
          lesson_id: file[0],
          title: get_lesson_title(file[0], @language),
          updated: file[1][0].updated,
          files: file[1].group_by { |x| x['ftype'].downcase }
      }
    end.select do |file|
      file[:title]
    end
  end

  private

  # Select updated files and their lesson IDs
  def get_updated_files(days)
    FileAsset.
        select("CONCAT( servers.httpurl, '/', files.filename ) AS 'link', files.filelang AS 'flang', files.filetype AS 'ftype', files.filesize AS 'fsize', files.updated  AS 'updated', lessonfiles.lessonid AS 'lessonid'").
        where(:'files.updated' => days.days.ago.to_s(:db)..0.days.ago.to_s(:db)).
        joins(:server, :lessons).
        order(:lessonid, :ftype).
        all.group_by { |x| x['lessonid'] }
  end

  def get_lesson_title(id, language)
    lesson = Lesson.find(id) rescue {lessonname: '----------', lessondate: '1970-01-01', created: '1970-01-01'}
    descr = lesson.lesson_descriptions.by_language(language).first.try(:lessondesc)
    lesson.lessonname = descr if descr

    if descr && (lesson.catalogs.map(&:id) & [3606, 3661, 3662]).empty?
      nil
    else
      lesson.lessonname +
          (lesson.lessondate.to_s == '0000-00-00' ? '' : " (#{lesson.lessondate})")
    end
  end

end
