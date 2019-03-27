$LOAD_PATH.unshift File.expand_path('../test', __FILE__)

load './test_helper.rb'
require 'minitest/autorun'
require 'aruba/api'

class FirstRun < Minitest::Test
  include Aruba::Api

  def setup
    aruba_setup
    @result1 = run_command("ruby argument_handler.rb",)
  end

  def testwork

  end

  def getting_started_with_aruba
    file = 'file.txt'
    content = 'Hello World'

    write_file file, content
    read(file).must_equal [content]
  end
end
