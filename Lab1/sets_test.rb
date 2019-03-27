require 'minitest/autorun'
#require 'open3'
load 'sets.rb'


# Tests
class TestSet < MiniTest::Test
  def setup
    @result1 = handleArgs('"Ruby":"Jan Kowalski"', '"Ruby":"Jan Kowalski":4.0', '"Ruby":"Jan Kowalski":5.0', '"JS":"AGH 100%":4.0')
  end

  def test_handle_args
    assert_equal(@result1, [{"\"Ruby\"" => ["\"Jan Kowalski\""], "\"JS\"" => ["\"AGH 100%\""]}, {"\"Jan Kowalski\"" => ["4.0", "5.0"], "\"AGH 100%\"" => ["4.0"]}])
  end

  def test_add_more_than_two
    hash = {}
    secondhash = {}
    Sets.person_insert(hash, "Ruby", "Jan Kowalski", secondhash)
    Sets.person_insert(hash, "Ruby", "Anna Nowak", secondhash)
    assert_raises(StandardError) {Sets.person_insert(hash, "Ruby", "Stanisław Kowalski", secondhash)}
  end

  def test_add_double_same_course
    hash = {}
    secondhash = {}
    Sets.person_insert(hash, "Ruby", "Jan Kowalski", secondhash)
    assert_raises(StandardError) {Sets.person_insert(hash, "Ruby", "Jan Kowalski", secondhash)}
  end
end