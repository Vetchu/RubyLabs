require './skrypt3.rb'

describe "Calculator" do
  it "adds numbers" do
    calc = Calculator.new
    expect(calc.add(2, 3)).to eql(5)
  end
  it "doesnt add strings" do
    calc = Calculator.new
    expect {calc.add("string", 3)}.to raise_error(ArgumentError)
  end
  it "divides numbers" do
    calc = Calculator.new
    expect(calc.divide(6, 3)).to eql(2)
  end
  it "doesnt divide strings" do
    calc = Calculator.new
    expect {calc.divide("string", 3)}.to raise_error(ArgumentError)
  end
  it "multiplies numbers" do
    calc = Calculator.new
    expect(calc.multiply(6, 3)).to eql(18)
  end
  it "doesnt multiply strings" do
    calc = Calculator.new
    expect {calc.multiply("string", 3)}.to raise_error(ArgumentError)
  end
end

describe "WordOperator" do
  it "reverses words" do
    wop = WordOperator.new
    expect(wop.reverse("abc")).to eql("cba")
  end
  it "swaps case" do
    wop = WordOperator.new
    expect(wop.swap("AbC")).to eql("aBc")
  end
  it "doesnt swaps case number" do
    wop = WordOperator.new
    expect {wop.swap(123)}.to raise_error(ArgumentError)
  end
  it "reverses word first" do
    wop = WordOperator.new
    expect(wop.reverse("abc sda")).to eql("cba")
  end
  it "swaps case one" do
    wop = WordOperator.new
    expect(wop.swap("AbC abc")).to eql("aBc")
  end
  it "doesnt reverse string" do
    wop = WordOperator.new
    expect {wop.reverse(123)}.to raise_error(ArgumentError)
  end
end