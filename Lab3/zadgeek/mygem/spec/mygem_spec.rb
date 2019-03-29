# Nazwa gema: 'DeanerySystem'

RSpec.describe DeanerySystem::Student do
  before(:each) do
    @student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
    @student1.add_score(4.0)
    @student1.add_score(5)
    ######################
    @student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
    @student2.add_score(4)
    @student2.add_score(4.0)
  end

  it 'has capitalized name' do
    expect(@student1.first_name).to eq('Joanna')
    expect(@student1.last_name).to eq('Kowalska')
  end

  it 'has unique id' do
    expect(@student1.id).not_to eq @student2.id
  end
  it 'has unmodifiable id' do
    expect {@student1.id = 1}.to raise_error NoMethodError
  end

  it 'can displays full information' do
    expect {puts @student1}.to output("Joanna Kowalska [4.0, 5.0] ma_stypendium\n").to_stdout
    expect {puts @student2}.to output("Jerzy Nowak [4.0, 4.0] nie_ma_stypendium\n").to_stdout
  end

  it 'can modify personal data' do
    @student1.first_name = 'Joanna Urszula'
    @student1.last_name = 'Nowak'
    expect(@student1.first_name).to eq 'Joanna Urszula'
    expect(@student1.last_name).to eq 'Nowak'
  end

  it 'properly stores scores' do
    expect(@student1.scores).to match_array([4.0, 5.0])
    expect(@student2.scores).to match_array([4.0, 4.0])
  end

  it 'correctly calculates the scholarship possession' do
    expect(@student1.has_scholarship?).to be_truthy
    expect(@student2.has_scholarship?).to be_falsy
  end
end

RSpec.describe DeanerySystem::University do
  before(:all) do
    @university = DeanerySystem::University.new
    @student1 = DeanerySystem::Student.new('JOANNA', 'KOWALSKA')
    @student2 = DeanerySystem::Student.new('Jerzy', 'Nowak')
  end

  it 'is empty at the beginning' do
    expect(@university.size).to eq(0)
  end

  it 'properly adds students' do
    @university.append(@student1)
    @university.append(@student2)
    expect(@university.size).to eq(2)
  end

  it 'properly implements the "[]" method' do
    expect(@university[@student1.id].first_name).to eq(@student1.first_name)
    expect(@university[@student2.id].first_name).to eq(@student2.first_name)
  end

  it 'can display full information' do
    expect {puts @university}.to output("Joanna Kowalska\nJerzy Nowak\n").to_stdout
  end
end