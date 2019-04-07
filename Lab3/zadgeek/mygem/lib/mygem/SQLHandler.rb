require "sqlite3"


class SQLHandler
  @db

  def initialize
    @db = SQLite3::Database.new "test.db"
    @db.execute <<-SQL
    create table IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      first_name varchar(30),
      last_name varchar(30)
      external INTEGER
    );
    SQL
    @db.execute <<-SQL
    create table IF NOT EXISTS grades (
      id INTEGER PRIMARY KEY,
      score varchar(30),
      type varchar(30)
      studentid INTEGER
    );
    SQL
  end

  def insert_student (student)
    student = student.get_info
    @db.execute("INSERT INTO students (first_name, last_name, external)
            VALUES (?, ?, ?)", student)
  end

  def update_student (student, new_student)
    student = student.get_info
    new_student = new_student.get_info

    @db.execute("UPDATE students SET (first_name, last_name, external)
            VALUES (?, ?, ?) WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'", new_student)
  end

  def delete_student (student)
    student = student.get_info
    @db.execute("DELETE FROM students
     WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'
      LIMIT 1 ")
  end

  def insert_grade (student, grade)
    id

    @db.execute("SELECT id FROM students
         WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'") do |row|
      id = row[0]
    end

    @db.execute("INSERT INTO grades (score, type, studentid)
            VALUES (?, ?, ?)", grade.score, grade.type, id)
  end

  def update_grade (old_student, new_student, old_grade, new_grade)
    id = nil
    id2 = nil

    @db.execute("SELECT id FROM students
                 WHERE first_name='" + old_student[0] + "' AND last_name='" + old_student[1] + "'") do |row|
      id = row[0]
    end

    unless new_student.nil?
      @db.execute("SELECT id FROM students
                   WHERE first_name='" + new_student[0] + "' AND last_name='" + new_student[1] + "'") do |row|
        id2 = row[0]
      end
    end
    if id2.nil?
      id2 = id
    end

    @db.execute("UPDATE grades SET (score, type, studentid)
                       VALUES (?, ?, ?) WHERE score='?' AND type='?' AND studentid='?'",
                new_grade.score, new_grade.type, id, old_grade.score, old_grade.type, id2)
  end

  def delete_grade (student, grade)
    student = student.getinfo
    id = nil
    @db.execute("SELECT id FROM students
                   WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'") do |row|
      id = row[0]
    end
    unless id.nil?
      @db.execute("DELETE FROM grades
                    WHERE score='?' AND type='?' AND studentid='?'
                    LIMIT 1", grade.score, grade.type, id)
    end
  end

end