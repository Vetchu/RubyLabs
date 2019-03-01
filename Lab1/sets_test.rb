require 'minitest/autorun'
load 'sets.rb'
require 'open3'
cmd = 'ruby test1.rb'
#You may change the contents of cmd like you would run it from the command line; like ruby [directory]/filename
Open3.popen3(cmd) do |stdin, stdout|
  var = stdout.read
  puts var
end


# Tests
class TestSum < MiniTest::Test
  def setup
    @result1 = Sets.hash_insert(2, 2)
    @result2 = sum(2, 1.5)
    @result3 = sum(2, '2')
  end

  def test_sum_integer_integer
    assert_equal(@result1, 4)
  end

end