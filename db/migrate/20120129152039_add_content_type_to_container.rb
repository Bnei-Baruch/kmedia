class AddContentTypeToContainer < ActiveRecord::Migration
  def self.up
    create_table :container_types do |t|
      t.string :name
      t.string :pattern
    end
    add_column :lessons, :container_type_id, :integer
    Lesson.reset_column_information

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
    ].each { |r| ContainerType.create(r) }
  end

  def self.down
    remove_column :lessons, :container_type_id
    drop_table :container_types
  end
end
