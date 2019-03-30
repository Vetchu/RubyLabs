require 'date'
require 'digest'
require 'objspace'
require "sqlite3"

db = SQLite3::Database.new "test.db"


module Grade
  NORMAL = 0
  FINISH = 1
  EXAM = 2
end

class DeanerySystem

  def count_fulltime
    ObjectSpace.each_object(DeanerySystem::FullTimeStudent).count
  end

  def count_external
    ObjectSpace.each_object(DeanerySystem::ExternalStudent).count
  end

  class Student
    attr_accessor :scores, :last_name, :first_name
    attr_reader :id
    @first_name
    @last_name
    @scores
    @id

    def initialize(name, surname)
      @scores = []
      name = name.downcase.capitalize
      surname = surname.downcase.capitalize
      @id = Digest::MD5.hexdigest(name + surname.to_s)

      @first_name = name
      @last_name = surname
    end

    def add_score(grade)
      grade = grade.to_f
      @scores.push(grade)
      @scores.sort
    end

    def has_scholarship?
      medium = 0
      for grade in @scores
        medium += grade
      end
      val = medium / @scores.length >= 4.5
    end

    def to_s
      val = @first_name + " " + @last_name
      medium = 0
      if @scores.length > 0
        val += " ["
      end
      i = 1
      for grade in @scores
        medium += grade
        if i < @scores.length
          val += grade.to_s + ", "
        else
          val += grade.to_s
        end
        i += 1
      end
      if @scores.length > 0
        val += "]"
      end
      val += " " + (has_scholarship? ? "ma_stypendium\n" : "nie_ma_stypendium")
      val.strip
      val
    end

    def get_info

    end
  end

  class FullTimeStudent < Student
    def get_info
      %w(@first_name @last_name 1)
    end
  end

  class ExternalStudent < Student
    def get_info
      %w(@first_name @last_name 0)
    end
  end
  class SQL_Handler
    def insert_student (student)
      student = student.get_info
      db.execute("INSERT INTO students (first_name, last_name, external)
            VALUES (?, ?, ?)", student)
    end

    def update_student (student, new_student)
      student = student.get_info
      new_student = new_student.get_info

      db.execute("UPDATE students SET (first_name, last_name, external)
            VALUES (?, ?, ?) WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'", new_student)
    end

    def delete_student (student)
      student = student.get_info
      db.execute("DELETE FROM students WHERE WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'")
    end

    def insert_grade (student, grade)
      id

      db.execute("SELECT id FROM students WHERE WHERE first_name='" + student[0] + "' AND last_name='" + student[1] + "'") do |row|
        id = row[0]
      end

      db.execute("INSERT INTO grades (score, type, studentid)
            VALUES (?, ?, ?)", grade.score, grade.type, id)
    end

    def update_grade (old_student, new_student, old_grade, new_grade)
      id = nil
      id2 = nil

      db.execute("SELECT id FROM students WHERE WHERE first_name='" + old_student[0] + "' AND last_name='" + old_student[1] + "'") do |row|
        id = row[0]
      end

      unless new_student.nil?
        db.execute("SELECT id FROM students WHERE WHERE first_name='" + new_student[0] + "' AND last_name='" + new_student[1] + "'") do |row|
          id2 = row[0]
        end

        if id2.nil?
          id2 = id
        end

        db.execute("UPDATE grades SET (score, type, studentid)
            VALUES (?, ?, ?) WHERE score='?' AND type='?' AND studentid='?'", new_grade.score, new_grade.type, id, old_grade.score, old_grade.type, id2)
      end

      def delete_grade (student, grade)

      end

    end
  end

  class Score
    attr_reader :type, :score
    @score
    @type

    def initialize(score, type)
      @score = score
      @type = type
    end

    def to_s
      @score
    end
  end

  class University
    attr_accessor :size
    @size
    @students

    def initialize
      @students = {}
      @size = 0
    end

    def [] (key)
      @students[key]
    end

    def append student
      @students[student.id] = student
      @size += 1
    end

    def to_s
      val = ""
      for studentid in @students.keys
        val += @students[studentid].first_name + " " + @students[studentid].last_name + "\n"
      end
      val
    end
  end


end
