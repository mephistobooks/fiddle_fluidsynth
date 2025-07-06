# frozen_string_literal: true
#
# filename: synth/synth_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::SynthTest < Test::Unit::TestCase

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
class FiddleFluidSynth::SynthTest

  #
  #
  #
  test "Synthesizer/top - Lifecycle" do

    #
    settings = FFS.settings_new
    tmp = FFS.synth_new(settings)

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    FFS.synth_delete(tmp)
    FFS.settings_delete(settings)

  end

end


#
#
#
class FiddleFluidSynth::SynthTest

  #
  #
  #

end


#### endof filename: synth/synth_test.rb
