require 'minitest/autorun'
load 'dlugosci.rb'

# Tests
class TestSum < MiniTest::Test
  def setup
    hash = {}
    @result1 = Dlugosci.count_occurencies(hash, "abcd efgh asdfads")
  end

  def test_count
    assert_equal(@result1, {4 => 2, 7 => 1})
  end
end