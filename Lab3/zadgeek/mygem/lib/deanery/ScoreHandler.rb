class ScoreHandler
  @db

  def initialize(db)
    @db = db
    @db.execute <<-SQL
    create table IF NOT EXISTS grades (
      id varchar(50) PRIMARY KEY,
      score Integer,
      type Integer,
      studentid Integer
    );
    SQL
  end

  def assign (student, grade)
    @db.execute("INSERT INTO grades (score, type, studentid)
            VALUES (?, ?, ?)", grade.score, grade.type, student.id)
  end

  def update (old_student, new_student, old_grade, new_grade)
    @db.execute("UPDATE grades SET (score, type, studentid)
                VALUES (?, ?, ?) WHERE score=? AND type=? AND studentid=? LIMIT 1",
                new_grade.score, new_grade.type, new_student.id, old_grade.score, old_grade.type, old_student.id)
  end

  def delete (student, grade)
    @db.execute("DELETE FROM grades WHERE studentid=? AND score=? AND type=? LIMIT 1", student.id, grade.score, grade.type)
  rescue
    puts "cannot delete student grade" + +grade.to_s
  end

  def delete_all (student)
    @db.execute("DELETE FROM grades WHERE studentid=?", student.id)
  rescue
    puts "cannot delete students grades" + +student.to_s
  end

  def grades student
    @db.execute("SELECT score,type FROM grades WHERE id=?", student.id)
  end

end