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
    expect($db.student_handler.get_all).to eq([DeanerySystem::FullTimeStudent.new("bottom", "text").get_info, DeanerySystem::ExternalStudent.new("bottom2", "text").get_info])
  end
  it 'finds students' do
    expect($db.student_handler.find "any", "any", 'fulltime').to eq([DeanerySystem::FullTimeStudent.new("bottom", "text").get_info])
  end

  it 'updates students' do
    $db.student_handler.update DeanerySystem::FullTimeStudent.new("bottom", "text"), DeanerySystem::ExternalStudent.new("tekst", "dolny")
    expect($db.student_handler.get_all).to eq([DeanerySystem::ExternalStudent.new("tekst", "dolny").get_info, DeanerySystem::ExternalStudent.new("bottom2", "text").get_info])
  end

  it 'deletes students' do
    $db.student_handler.delete DeanerySystem::FullTimeStudent.new("tekst", "dolny")
    expect($db.student_handler.get_all).to eq([DeanerySystem::ExternalStudent.new("bottom2", "text").get_info])
  end

  it 'assigns grades' do
    $db.score_handler.assign DeanerySystem::ExternalStudent.new("bottom2", "text"), Score.new(5.0, 0)
    $db.score_handler.assign DeanerySystem::ExternalStudent.new("bottom2", "text"), Score.new(5.0, 1)
    $db.score_handler.assign DeanerySystem::ExternalStudent.new("bottom2", "text"), Score.new(5.0, 2)
    expect($db.score_handler.grades DeanerySystem::ExternalStudent.new("bottom2", "text")).to eq([[5.0, "normal"], [5.0, "exam"], [5.0, "end"]])
  end
  it 'updates grades' do

  end
  it 'deletes grades' do
    $db.score_handler.delete_all DeanerySystem::ExternalStudent.new("bottom2", "text")
    expect($db.score_handler.grades DeanerySystem::ExternalStudent.new("bottom2", "text")).to eq([])
  end

  after(:all) do
    File.delete("tmp.db")
  end
end