require 'minitest/autorun'
load 'main.rb'

# Tests
class TestSum < MiniTest::Test
  def setup
    @result1 = sum(2, 2)
    @result2 = sum(2, 1.5)
    @result3 = sum(2, '2')
    @result4 = sum('2.1', '2.0')
    @result5 = sum('2/5',3/5r)
    @result6 = sum('0.5+2i',4-1i)
    @result7 = sum('1+2i',3/5r)
  end

  def test_sum_integer_integer
    assert_equal(@result1, 4)
  end

  def test_sum_integer_float
    assert_equal(@result2, 3.5)
  end

  def test_sum_integer_string
     assert_equal(@result3, 4)
  end

  def test_sum_string_string
     assert_equal(@result4, 4.1)
  end

  def test_sum_rational_string
    assert_equal(@result5, 1)
  end
  def test_sum_complex_string
    assert_equal(@result6, 4.5+1i)
  end
  def test_sum_rational_complex
    assert_equal(@result7, 1.6+2i)
  end

  def test_sum_array_int
    assert_raises(TypeError) {sum(1, [2, 3])}
  end

  def test_sum_integer_wrong_number_in_string
    assert_raises(TypeError) {sum(2, 'Ala ma kota123')}
     # assert_equal(sum(2, 'Ala ma kota123'), 2)
  end
end