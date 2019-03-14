require 'minitest/autorun'
#require 'open3'
require './sets.rb'
#
# cmd = 'ruby sets_test.rb'
# #You may change the contents of cmd like you would run it from the command line; like ruby [directory]/filename
# Open3.popen3(cmd) do |stdin, stdout|
#   var = stdout.read
#   puts var
# end

# Tests
class TestSet < MiniTest::Test
  def setup
    @result2 = test_handle_args
    #Sets.hash_insert($hash,"Jan Kowalski","Ruby")
    #@result1=insert_double
    #@result1 = Sets.hash_insert(2, 2,2)
  end

  def test_handle_args
    assert(handleArgs('"Ruby":"Jan Kowalski" "Ruby":"Jan Kowalski":4.0 "Ruby":"Jan Kowalski" "JS":"JP 100%":4.0 --wypisz') == nil)
  end
  #
  # def test_sum_integer_integer
  #   assert_raises(StandardError){Sets.hash_insert($hash,"Jan Kowalski","Ruby")}
  # end

end