class FillInConteinerTypes < ActiveRecord::Migration
  def self.up
    # Set Container type for recognizable patterns
    ContentType.all.each do |ct|
      execute "UPDATE lessons SET container_type_id = #{ct.id} WHERE lessonname LIKE '%_#{ct.pattern}_%';"
      execute "UPDATE lessons SET container_type_id = #{ct.id} WHERE lessonname LIKE '%_#{ct.pattern}.%';"
    end
    # All lessons with unknown contaier type will be ... lessons!
    lct = ContentType.find_by_pattern 'lesson'
    execute "UPDATE lessons SET container_type_id = #{lct.id} WHERE container_type_id IS NULL;"
  end

  def self.down
  end
end
