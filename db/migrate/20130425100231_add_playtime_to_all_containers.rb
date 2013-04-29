class AddPlaytimeToAllContainers < ActiveRecord::Migration
  def change
    Lesson.where(playtime_secs: nil).find_in_batches do |group|
      group.each do |lesson|
        puts "################ #{lesson.lessonname} ##################################"
        playtime_seconds = lesson.playtime_secs.to_i
        puts "Lesson playtime before: #{playtime_seconds}"
        lesson.file_assets.each do |file|
          puts "File: #{file.filename} #{file.filetype} #{file.playtime_secs.to_i}"
          playtime_seconds = if playtime_seconds > 0
                               playtime_seconds
                             elsif file.playtime_secs.to_i > 0
                               file.playtime_secs.to_i
                             elsif file.filetype == 'mp3'
                               begin
                                 m = Mp3Info.new(open(file.url))
                                 m.length.round(0)
                               rescue Exception => e
                                 puts ">>>>>>>>>>>> Exception: #{e.message}"
                                 0
                               end
                             elsif %w{wma wmv asf}.include? file.filetype
                               begin
                                 f = WmaInfo.new(open(file.url))
                                 f.info['playtime_seconds']
                               rescue Exception => e
                                 puts ">>>>>>>>>>>> Exception: #{e.message}"
                                 0
                               end
                             end || 0
          puts "Calculated: #{playtime_seconds}"
          lesson.update_attribute(:playtime_secs, playtime_seconds) if lesson.playtime_secs.to_i == 0
          file.update_attribute(:playtime_secs, playtime_seconds) if file.playtime_secs.to_i == 0
        end
        puts "Lesson playtime after: #{playtime_seconds}"
      end
    end
  end
end