require_relative 'DeanerySystem'

class Commands
  attr_accessor :dean
  @dean
  def initialize
    @dean = DeanerySystem.new
  end

  def insert_student(name, surname, external)
    if external
      $db.student_handler.insert DeanerySystem::ExternalStudent.new(name, surname)
    else
      $db.student_handler.insert DeanerySystem::FullTimeStudent.new(name, surname)
    end
  end

  def update_student(name1, surname1, name, surname, external)
    if external
      $db.student_handler.update DeanerySystem::Student(name1, surname1), DeanerySystem::ExternalStudent.new(name, surname)
    else
      $db.student_handler.update DeanerySystem::Student(name1, surname1), DeanerySystem::FullTimeStudent.new(name, surname)
    end
  end

  def delete_student(name, surname)
    $db.student_handler.delete DeanerySystem::Student.new(name, surname)
  end

  def assign_grade(name, surname, score, type)
    $db.score_handler.assign DeanerySystem::Student.new(name, surname), Score.new(score, type)
  end

  def update_grade(name, surname, score1, type1, score, type)
    $db.score_handler.update DeanerySystem::Student.new(name, surname), DeanerySystem::Student(name, surname), Score.new(score1, type1), Score.new(score, type)
  end

  def remove_grade(name, surname, score, type)
    $db.score_handler.delete DeanerySystem::Student.new(name, surname), Score.new(score, type)
  end

  def grades(name, surname)
    $db.score_handler.grades DeanerySystem::Student.new(name, surname)
  end

  def get_all_students
    $db.student_handler.get_all {|student| $db.score_handler.grades(student) {|score| student.add score[1], score[2], "NEW"}}
  end

  def find (name, surname, external)
    $db.student_handler.find name, surname, external
  end
end