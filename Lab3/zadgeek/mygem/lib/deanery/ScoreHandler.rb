class ScoreHandler
  @db

  def initialize(db)
    @db = db
    @db.execute <<-SQL
    create table IF NOT EXISTS grades (
      id varchar(50) PRIMARY KEY,
      score Float,
      type Integer,
      studentid Integer
    );
    SQL
  end

  def assign (student, grade)
    student = student.get_info
    grade = grade.get_info
    @db.execute("INSERT INTO grades (score, type, studentid)
            VALUES (?, ?, ?)", grade, student[0])
  end

  def update (old_student, new_student, old_grade, new_grade)
    @db.execute("UPDATE grades SET (score, type, studentid)
                VALUES (?, ?, ?) WHERE score=? AND type=? AND studentid=? LIMIT 1",
                new_grade.score, new_grade.type, new_student.id, old_grade.score, old_grade.type, old_student.id)
  end

  def delete (student, grade)
    student = student.get_info
    grade = grade.get_info
    puts student.to_s
    @db.execute("DELETE FROM grades WHERE score=? AND type=? AND studentid=?;", grade, student[0])
      #rescue
      # puts "cannot delete student grade" + student[0]+" " +grade.to_s
  end

  def delete_all (student)
    @db.execute("DELETE FROM grades WHERE studentid=?", student.id)
  rescue
    puts "cannot delete students grades" + +student.to_s
  end

  def grades(student)
    student = student.get_info
    @db.execute("SELECT score,type FROM grades WHERE studentid=?", student[0])

  end

end