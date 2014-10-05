class CreateContainerCreationPatterns < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.table_exists? :container_creation_patterns
      create_table :container_creation_patterns do |t|
        t.string :pattern
        t.string :result

        t.timestamps
      end
    end
  end
end
