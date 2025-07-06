# frozen_string_literal: true
#
# filename: command_interface/command_interface_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::CommandInterfaceTest < Test::Unit::TestCase

  #FFS  = FiddleFluidSynth

  #
  def self.startup; end
  def self.shutdown
    FFS.raise_error_in_callback
  end

  #
  def setup
    # @ffs = FiddleFluidSynth.new
  end
  def teardown
    FFS.raise_error_in_callback
    # @ffs.delete()
  end

end


#
class FiddleFluidSynth::CommandInterfaceTest

  #
  #
  #
  test "Command Interface" do

    #
    ret = FFS.get_stdin()
    exp = 0
    assert_equal exp, ret

    #
    ret = FFS.get_stdout()
    exp = 1
    assert_equal exp, ret

  end


end


#### endof filename: command_interface/command_interface_test.rb
