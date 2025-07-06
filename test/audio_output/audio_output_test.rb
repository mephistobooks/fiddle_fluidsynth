# frozen_string_literal: true
#
# filename: audio_output/audio_output_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::AudioOutputTest < Test::Unit::TestCase

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
class FiddleFluidSynth::AudioOutputTest

  #
  #
  #
  test "Audio Driver initialize" do

    #
    settings = FFS.settings_new()
    synth    = FFS.synth_new(settings)

    tmp = FFS.audio_driver_new(settings: settings, synth: synth)

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.audio_driver_delete(tmp)
    FFS.synth_delete(synth)
    FFS.settings_delete(settings)

  end

  #
  #
  #
  test "Audio Driver initialize (2)" do

    #
    settings = FFS.settings_new()
    # synth    = FFS.synth_new(settings)

    tmp = FFS.audio_driver_new2(settings: settings, audio_func: nil, data: nil)

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.audio_driver_delete(tmp)
    FFS.settings_delete(settings)

  end

end


# File Renderer.
#
#
class FiddleFluidSynth::AudioOutputTest

  #
  #
  #
  test "File Renderer initialize" do

    #
    settings = FFS.settings_new()
    synth    = FFS.synth_new(settings)

    tmp = FFS.file_renderer_new(synth)

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.file_renderer_delete(tmp)
    FFS.synth_delete(synth)
    FFS.settings_delete(settings)

  end

end


#### endof filename: audio_output/audio_output_test.rb
