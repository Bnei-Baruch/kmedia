class FixLessondateInLessons < ActiveRecord::Migration
  def self.up
    execute "DROP FUNCTION IF EXISTS fixDate;"
    sql = <<-SQL
CREATE FUNCTION fixDate(eval_date VARCHAR(1024)) RETURNS DATE
BEGIN
  DECLARE my_data VARCHAR(10);
  IF NOT(ISNULL(DATEDIFF(CURRENT_DATE,eval_date))) AND (YEAR(eval_date) > 1900) THEN
    return eval_date;
  ELSE
    IF (YEAR(eval_date) > 1900) THEN
      SET my_data = concat(YEAR(eval_date));
      IF (MONTH(eval_date) < 1 OR MONTH(eval_date) > 12) THEN
        SET my_data = concat(my_data, '-', 1);
      ELSE
        SET my_data = concat(my_data, '-', MONTH(eval_date));
      END IF;
      IF (DAY(eval_date) < 1 OR DAY(eval_date) > 31) THEN
        SET my_data = concat(my_data, '-', 1);
      ELSE
        SET my_data = concat(my_data, '-', DAY(eval_date));
      END IF;
      return DATE_ADD(my_data, INTERVAL 0 DAY);
    END IF;
    return null;
  END IF;
END;
    SQL
    execute sql
    execute "DROP TRIGGER IF EXISTS lessons_fixdate_update;"
    sql = <<-SQL
CREATE TRIGGER lessons_fixdate_update BEFORE UPDATE ON lessons
FOR EACH ROW
BEGIN
  SET NEW.lessondate = fixdate(NEW.lessondate);
END;
    SQL
    execute sql

    execute "DROP TRIGGER IF EXISTS lessons_fixdate_insert;"
    sql = <<-SQL
CREATE TRIGGER lessons_fixdate_insert BEFORE INSERT ON lessons
FOR EACH ROW
BEGIN
  SET NEW.lessondate = fixdate(NEW.lessondate);
END;
    SQL
    execute sql

    sql = <<-SQL
update lessons set
  lessondate = fixdate(lessondate)
    SQL
    execute sql

  end

  def self.down
    sql = <<-SQL
DROP FUNCTION IF EXISTS fixDate;
DROP TRIGGER IF EXISTS lessons_fixdate_update;
DROP TRIGGER IF EXISTS lessons_fixdate_insert;
    SQL
    esecute sql
  end
end
