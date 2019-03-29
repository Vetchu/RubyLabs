require "sqlite3"

# Open a database
db = SQLite3::Database.new "test.db"

# Create a table
rows = db.execute <<-SQL
  create table IF NOT EXISTS  numbers (
    columnIndex INTEGER PRIMARY KEY,
    name varchar(30)
  );
SQL

# Execute a few inserts
{
    1 => "one",
    2 => "two",
}.each do |pair|
  db.execute "insert into numbers values ( ?, ? )", pair rescue puts "index modofoka"
end

# Find a few rows
db.execute("select * from numbers") do |row|
  p row
end

# Create another table with multiple columns

db.execute <<-SQL
  create table IF NOT EXISTS students (
    name varchar(50),
    surname varchar(50),
    grade varchar(5)
  );
SQL
student = %w(Jane me@janedoe.com A)

# Execute inserts with parameter markers
db.execute("INSERT INTO students (name, surname, grade)
            VALUES (?, ?, ?)", student)

db.execute("select * from students") do |row|
  p row
end
db.execute("select * from students WHERE name='" + student[0] + "'") do |row|
  p row
end