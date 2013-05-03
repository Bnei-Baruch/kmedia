class PhpController < ApplicationController

  def wsxml

    #$les=get_lessons($CID,$cat,($CID?0:1));
    #if(count($les) > 500) $les = array_slice($les, 0, 500, true);

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

    respond_to do |format|
      format.xml
    end
  end
end
