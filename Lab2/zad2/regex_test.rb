require 'minitest/autorun'
load './Lab2/regex.rb'

class TestRegex < MiniTest::Test
  def setup
    @result1 = word_number("numer123")
    @result2 = word_number("123numer")
  end

  def test_simple_case
    assert_equal(@result1, {"Liczba" => "123", "Wyraz" => "numer"})
  end

  def test_reverse_case
    assert_equal(@result1, {"Liczba" => "123", "Wyraz" => "numer"})
  end
end