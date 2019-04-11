class Student_Handler
  @db

  def initialize(db)
    @db = db
    @db.execute <<-SQL
    create table IF NOT EXISTS students (
      id varchar(50) PRIMARY KEY,
      first_name varchar(50),
      last_name varchar(50),
      is_external Integer
    );
    SQL
  end

  def insert (student)
    student = student.get_info
    @db.execute("INSERT INTO students (id,first_name, last_name, is_external)
            VALUES (?, ?, ?, ?)", student)
  rescue
    puts "cannot insert student " + student.to_s
  end

  def update (student, new_student)
    student = student.get_info
    new_student = new_student.get_info

    @db.execute("UPDATE students SET id=?, first_name=?, last_name=?, is_external=?
                 WHERE id=?", new_student, student[0])
    # rescue
    #  puts "cannot update student " + student[0] +new_student.to_s
  end

  def delete (student)
    student = student.get_info
    @db.execute("DELETE FROM students WHERE id=? ", student[0])
  rescue
    puts "cannot delete student " + +student[0]
  end

  def get_all
    rows = @db.execute("SELECT * FROM students").each {|row|
      #puts row
      (!row[3].nil? && row[3] == 0) ?
          DeanerySystem::FullTimeStudent.new(row[1], row[2]) :
          DeanerySystem::ExternalStudent.new(row[1], row[2])
    }
    rows
  end

  def find (name, surname, external)
    if external == 'any'
      external = 'any'
    elsif external == 'fulltime'
      external = 0;
    else
      external = 1;
    end
    #puts name.to_s + surname.to_s + external.to_s

    rows = get_all.keep_if {|student|
      namebool = name == 'any' ? true : student[1] == name
      surnamebool = surname == 'any' ? true : student[2] == surname
      externalbool = external == 'any' ? true : student[3] == external
      namebool && surnamebool && externalbool
    }

    rows
  end
end