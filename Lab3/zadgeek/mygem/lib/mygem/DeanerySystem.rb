require 'date'
require 'digest'
require 'objspace'


class DeanerySystem
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

  def count_fulltime
    ObjectSpace.each_object(DeanerySystem::FullTimeStudent).count
  end

  def count_external
    ObjectSpace.each_object(DeanerySystem::ExternalStudent).count
  end
end
