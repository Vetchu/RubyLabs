require_relative "deanery/DeanerySystem.rb"
require_relative "deanery/SqliteDriver.rb"
require_relative "deanery/SimpleCommands.rb"

module Deanery

end

$db

# @student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
# @student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
# puts @student1.id
sql = SQL_Handler.new("test2")
dean = DeanerySystem.new
#  student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
#  student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
#
#sql.student_handler.insert student2
#sql.score_handler.insert student1,Score.new(5.0,2)
sql.student_handler.get_all