class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :lesson_transcripts do |t|
      t.integer :lessonid
      t.string :toc
      t.text :transcript
      t.string :lang
      t.timestamps
    end
  end
end
