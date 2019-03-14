#$LOAD_PATH.unshift File.expand_path('../test', __FILE__)

load 'test/test_helper.rb'
require 'minitest/autorun'

class FirstRun < Minitest::Test
  include Aruba::Api

  def setup
    setup_aruba
  end

  def test_getting_started_with_aruba
    # file = 'file.txt'
    # content = 'Hello, Aruba!'
    #
    # write_file file, content
    #
    # #run_command_and_stop './argument_handler.rb -h'
    # assert_equal last_command_started.output.chomp, content
  end
end