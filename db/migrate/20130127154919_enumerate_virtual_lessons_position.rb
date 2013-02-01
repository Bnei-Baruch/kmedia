class EnumerateVirtualLessonsPosition < ActiveRecord::Migration
  def up
    position = 0
    last_date = nil
    VirtualLesson.order('film_date ASC').each do |vl|
      if vl.film_date != last_date
        position = 0
        last_date = vl.film_date
      end
      position += 1
      vl.update_column(:position, position) # Skips callbacks and validations
    end
  end

  def down

  end
end
