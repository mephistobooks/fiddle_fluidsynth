# frozen_string_literal: true

require "test_helper"
require "fiddle_fluidsynth"


class FiddleFluidSynthTest < Test::Unit::TestCase

  #FFS  = FiddleFluidSynth

  #
  def self.startup; end
  def self.shutdown
    FFS.raise_error_in_callback
  end

  #
  def setup
    @ffs = FiddleFluidSynth.new
  end
  def teardown
    FFS.raise_error_in_callback
    @ffs.delete()
  end

end


class FiddleFluidSynthTest

  #
  test "VERSION" do
    assert do
      ::FiddleFluidSynth.const_defined?(:VERSION)
    end
  end

  # libfluidsynth version
  #
  #
  test "libfluidsynth version" do

    tmp = FFS.fluidsynth_version
    # [2, 4, 6]

    ret = tmp[0] >= 2
    exp = true
    assert_equal exp, ret

    ret = tmp[1] >= 4
    exp = true
    assert_equal exp, ret

    ret = tmp[-1] >= 6
    exp = true
    assert_equal exp, ret

    ret = FFS.fluidsynth_version_str
    exp = /\d+\.\d+\.\d+/
    assert_match exp, ret

  end

end


class FiddleFluidSynthTest

  # test "something useful" do
  #   assert_equal("expected", "actual")
  # end

  #
  test "is_soundfont?" do
    ret = FFS.is_soundfont "/opt/homebrew/share/fluid-synth/sf2/default.sf2"
    exp = 1
    assert_equal exp, ret

    # test for the non-existing soundfont file.
    ret = stderr_to_devnull{ FFS.is_soundfont "foo" }
    exp = 0
    assert_equal exp, ret

    #
    ret = FFS.is_soundfont? "#{__dir__}/../examples/example.sf2"
    exp = true
    assert_equal exp, ret

    ret = @ffs.is_soundfont? "#{__dir__}/../examples/example.sf2"
    exp = true
    assert_equal exp, ret

    #
    tmp = assert_raise {
            stderr_to_devnull{
              @ffs.is_soundfont? "#{__dir__}/../examples/foo"
            }
          }
    ret = tmp.message
    exp = /No such file: /
    assert_match exp, ret
  end

end
