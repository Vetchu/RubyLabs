require 'rspec'

RSpec.describe SQL_Handler do
  it 'inserts students' do
    SQL_Handler.new("testdb").student_handler.insert DeanerySystem::FullTimeStudent, new()
  end

  it 'assigns grades' do

  end
end