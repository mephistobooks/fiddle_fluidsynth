# frozen_string_literal: true
#
# filename: logging/logging_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::LoggingTest < Test::Unit::TestCase

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
class FiddleFluidSynth::LoggingTest

  #
  #
  #
  test "Logging - Constants" do

    #
    ret = FFS::Enum_fluid_log_level
    exp = FFS::Enum_fluid_log_level
    assert_equal exp, ret

    tmp_ary = [
      FFS::FLUID_PANIC,
      FFS::FLUID_ERR,
      FFS::FLUID_WARN,
      FFS::FLUID_INFO,
      FFS::FLUID_DBG,
      FFS::LAST_LOG_LEVEL,
    ]
    ret = tmp_ary
    exp = [ 0, 1, 2, 3, 4, 5, ]
    assert_equal exp, ret


  end


end


#### endof filename: logging/logging_test.rb
