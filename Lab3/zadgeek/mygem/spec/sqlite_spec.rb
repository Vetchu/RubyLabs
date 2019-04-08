require 'rspec'
require 'deanery'

$db
RSpec.describe SQL_Handler do
  before(:all) do
    $db = SQL_Handler.new("tmp.db")
  end

  it 'inserts students' do
    $db.student_handler.insert DeanerySystem::FullTimeStudent.new("bottom", "text")
    $db.student_handler.insert DeanerySystem::ExternalStudent.new("bottom2", "text")
  end
  it 'reads students' do
    $db.student_handler.get_all
  end
  it 'updates students' do
    $db.student_handler.update DeanerySystem::FullTimeStudent.new("bottom", "text"), DeanerySystem::ExternalStudent.new("tekst", "dolny")
    expect($db.student_handler.get_all).to eq([DeanerySystem::FullTimeStudent.new("tekst", "dolny").get_info, DeanerySystem::ExternalStudent.new("bottom2", "text").get_info])

  end
  it 'deletes students' do
    $db.student_handler.delete DeanerySystem::FullTimeStudent.new("bottom", "text")
    expect($db.student_handler.get_all).to eq([DeanerySystem::ExternalStudent.new("bottom2", "text").get_info])
  end

  it 'assigns grades' do
    $db.score_handler.assign DeanerySystem::FullTimeStudent.new("bottom", "text"), Score.new(5.0, 2)

  end

  it 'deletes grades' do
    $db.score_handler.delete_all DeanerySystem::FullTimeStudent.new("bottom", "text")

  end
  it 'reads student`s grades' do
    $db.score_handler.grades DeanerySystem::FullTimeStudent.new("bottom", "text")

  end

  after(:all) do
    File.delete("tmp.db")
  end
end