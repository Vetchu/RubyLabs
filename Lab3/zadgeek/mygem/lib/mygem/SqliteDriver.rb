require "sqlite3"
require_relative 'StudentHandler'
require_relative 'ScoreHandler'

class SQL_Handler
  attr_reader :score_handler, :student_handler
  @db
  @student_handler
  @score_handler

  def initialize(dbname)
    # Open a database
    @db = SQLite3::Database.new(dbname)

    @student_handler = Student_Handler.new(@db)
    @score_handler = ScoreHandler.new(@db)
  end
end

