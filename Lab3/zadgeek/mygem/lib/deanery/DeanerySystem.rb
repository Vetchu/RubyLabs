require 'date'
require 'digest'
require 'objspace'
require_relative 'Score'
require_relative 'SqliteDriver'

$db

class DeanerySystem
  attr_reader :db

  def initialize(options = [])
    unless $db
      if options[0].nil?
        $db = SQL_Handler.new("test")
      else
        $db = SQL_Handler.new(options[0])
      end
    end
  end

  def count_fulltime
    ObjectSpace.each_object(DeanerySystem::FullTimeStudent).count
  end

  def count_external
    ObjectSpace.each_object(DeanerySystem::ExternalStudent).count
  end

  class Student
    attr_accessor :last_name, :first_name
    attr_reader :id

    @id
    @first_name
    @last_name
    @scores

    def initialize(name, surname)
      @scores = []

      name = name.downcase.capitalize
      surname = surname.downcase.capitalize

      @id = Digest::MD5.hexdigest(name + surname)
      @first_name = name
      @last_name = surname
    end

    def scores
      @scores.collect(&:score)
    end

    def add_score(grade, options = [])
      score = Score.new(grade.to_f, options[0])
      @scores.push(score)
      @scores.sort_by(&:score)
    end

    def has_scholarship?
      @scores.empty? ? false : @scores.collect(&:score).inject(:+) / @scores.length >= 4.5
    end

    def to_s
      @first_name + " " + @last_name + " " + scores.to_s + " " + (has_scholarship? ? "ma_stypendium\n" : "nie_ma_stypendium")
    end

    def get_info
      [@id, @first_name, @last_name]
    end
  end

  class FullTimeStudent < Student
    def get_info
      [@id, @first_name, @last_name, 0]
    end
  end

  class ExternalStudent < Student
    def get_info
      [@id, @first_name, @last_name, 1]
    end
  end

  class University
    attr_reader :size
    @students

    def size
      @students.size
    end

    def initialize
      unless $db
        $db = SQL_Handler.new("test")
      end
      @students = {}
    end

    def [] (key)
      @students[key]
    end

    def append student
      @students[student.id] = student
    end

    def to_s
      @students.keys.collect {|studentid| "#{@students[studentid].first_name} #{@students[studentid].last_name}"}.join("\n")
    end
  end
end
