class PhpController < ApplicationController

  respond_to :xml

  def wsxml
    # Example
    # wsxml.xml?CID=4016&DLANG=HEB&DF=2013-04-30&DT=2013-03-31

    @language = params[:DLANG] || 'ENG'

    catalog_id = params[:CID] || 25
    date_from = params[:DF] || Date.today.to_s
    date_to = params[:DT] || (Date.today - 30).to_s

    catalogs = Catalog.find(catalog_id).all_children_with_root.map(&:id).join(',')

    sql = <<-SQL
      select distinct l.*
      from lessons l, catnodelessons cnl
      where
        l.lessonid = cnl.lessonid and
        ( cnl.catalognodeid in (#{catalogs})  and
        (l.lessondate BETWEEN '#{date_to}' and '#{date_from}')  and
        l.secure=0 )
      order by l.lessondate desc, created desc, lessonname asc
    SQL

    @lessons = Lesson.find_by_sql sql

    @server = "http://#{request.env['HTTP_HOST']}/#{Language::CODE3_LOCALE[@language]}/ui"

    respond_with @lessons
  end
end
