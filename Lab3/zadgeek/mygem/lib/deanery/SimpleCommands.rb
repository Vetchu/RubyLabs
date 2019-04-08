require_relative 'DeanerySystem'

class Commands
  def initialize
    dean = DeanerySystem.new
  end

  def insert_student(name, surname, external)
    if external
      $db.student_handler.insert DeanerySystem::ExternalStudent.new(name, surname)
    else
      $db.student_handler.insert DeanerySystem::FullTimeStudent.new(name, surname)
    end
  end

  def update_student(student, name, surname, external)
    if external
      $db.student_handler.update student, DeanerySystem::ExternalStudent.new(name, surname)
    else
      $db.student_handler.update student, DeanerySystem::FullTimeStudent.new(name, surname)
    end
  end

  def delete_student(student)
    $db.student_handler.delete student
  end

  def assign_grade(student, grade)
    $db.score_handler.insert student, grade
  end

  def update_grade(student, grade, score, type)
    $db.score_handler.update student, student, grade, Score.new(score, type)
  end

  def remove_grade(grade)
    $db.score_handler.remove grade
  end

  def get_all_students_and_grades
    $db.student_handler.get_all {|student| $db.score_handler.grades(student) {|score| student.add score[1], score[2], "NEW"}}
  end

end