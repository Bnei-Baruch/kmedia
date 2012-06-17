class FillInConteinerTypes < ActiveRecord::Migration

  # nested classes make our migrations independent of the real model.
  class ContainerType < ActiveRecord::Base
    has_many :lessons
  end

  def self.up
    # create default container types
    [
        {:name => 'Program', :pattern => 'program'},
        {:name => 'Short clip', :pattern => 'clip'},
        {:name => 'Song', :pattern => 'song'},
        {:name => 'Lesson', :pattern => 'lesson'},
        {:name => 'Lecture', :pattern => 'lecture'},
        {:name => 'Book', :pattern => 'book'},
        {:name => 'Declamation', :pattern => 'declamation'},
        {:name => 'Audio Disk', :pattern => 'audiodisk'},
        {:name => 'Video Disk', :pattern => 'videodisk'},
        {:name => 'Text', :pattern => 'text'},
        {:name => 'Transcript', :pattern => 'tamlil'},
        {:name => 'Magazine', :pattern => 'magazine'},
    ].each{|r| ContainerType.create(r)}

    # Set Container type for recognizable patterns
    ContainerType.all.each do |ct|
      execute "UPDATE lessons SET container_type_id = #{ct.id} WHERE lessonname LIKE '%_#{ct.pattern}_%';"
      execute "UPDATE lessons SET container_type_id = #{ct.id} WHERE lessonname LIKE '%_#{ct.pattern}.%';"
    end
    # All lessons with unknown contaier type will be ... lessons!
    lct = ContainerType.find_by_pattern 'lesson'
    execute "UPDATE lessons SET container_type_id = #{lct.id} WHERE container_type_id IS NULL;"
  end

  def self.down
  end
end
