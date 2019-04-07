require_relative "mygem/DeanerySystem.rb"
require_relative "mygem/SqliteDriver.rb"
require_relative "mygem/SimpleCommands.rb"

module Mygem
  $db


end

# @student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
# @student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
# puts @student1.id
sql = SQL_Handler.new("test2")
dean = DeanerySystem.new
#  student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
#  student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
#
# sql.student_handler.insert_student student2
#sql.score_handler.insert student1,Score.new(5.0,2)
puts sql.student_handler.get_all