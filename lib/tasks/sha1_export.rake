task :sha1_export => :environment do
  sql = <<~SQL
      COPY (
        select servers.servername, path, name
        from file_assets
        left outer join servers on servers.servername = file_assets.servername
	where sha1 is null
        order by file_assets.id desc
    ) TO STDOUT WITH CSV HEADER;
  SQL
  puts FileAsset.connection.execute(sql)
end

require 'csv'

task :sha1_import => :environment do
  # Server.where(path: '/media/kids/2002/').first.update_attributes(path: '/media/kids/2002') rescue 0
  # Server.where(path: '/media/kids/2003/').first.update_attributes(path: '/media/kids/2003') rescue 0
  # read csv
  csv_text = File.read(ENV['CSV'])
  csv      = CSV.parse(csv_text, :headers => true)
  sql      = []
  csv.each do |row|
    servername, path, name, sha1, size = row[0], row[1], row[2], row[3], row[4]
    f                                  = FileAsset.where(name: name) #, 'servers.servername': servername, 'servers.path': path).joins('LEFT OUTER JOIN servers on servers.servername = file_assets.servername')
    case f.count
      when 0
        # puts "NOT FOUND #{name}"
      when 1
        begin
          ActiveRecord::Base.connection.execute("update file_assets set size=#{size}, sha1='#{sha1}' where id = #{f.pluck(:id)[0]};")
          puts "UPDATED #{name}"
        rescue Exception => msg
          puts "FAILURE #{name}: #{msg}"
        end
      else
        puts "NOT UNIQ #{name}"
    end
  end
end

task :correct_asset_types => :environment do
  FileAsset.where(asset_type: [nil, '.mp', '.wm', 'son']).all.to_a.each do |fa|
    fa.update_column :asset_type, File.extname(fa.name)[1..10]
  end
  %w(ZIP MP3 FLV WMV DOC Doc JPG).each do |ext|
    FileAsset.where(asset_type: ext).all.to_a.each do |fa|
      fa.update_column :asset_type, ext.downcase
    end
  end
  FileAsset.find_by_sql("DELETE FROM file_assets WHERE name = 'filelist.php'")
  FileAsset.find_by_sql("DELETE FROM file_assets WHERE asset_type IN ('tmp', 'lnk')")
end
