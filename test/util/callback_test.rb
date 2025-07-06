# frozen_string_literal: true
#
# filename: synth/synth_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::CallbackTest < Test::Unit::TestCase

  #
  def self.startup; end
  def self.shutdown
    FFS.raise_error_in_callback
  end

  #
  def setup
    FFS.error_in_callback = nil
    # @ffs = FiddleFluidSynth.new
  end
  def teardown
    FFS.raise_error_in_callback
    # @ffs.delete()
  end

end


#
class FiddleFluidSynth::CallbackTest

  #
  #
  #
  test "Util/CallbackTest" do

    #
    FFS.error_in_callback = RuntimeError.new("test.")

    tmp = assert_raise{
      FFS.raise_error_in_callback
    }
    ret = tmp.message
    exp = "test."
    assert_equal exp, ret

    #
    tmp = nil
    stderr_to_devnull {
      tmp = assert_nothing_raised {
        FFS.notify_error_in_callback
      }
    }
    ret = tmp.message
    exp = "test."
    assert_equal exp, ret


    FFS.error_in_callback = nil

  end

end


#### endof filename: util/callback_test.rb
