# frozen_string_literal: true
#
# filename: settings/settings_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::SettingsTest < Test::Unit::TestCase

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
class FiddleFluidSynth::SettingsTest

  #
  #
  #
  test "Settings - Constants: Macros" do

    #
    ret = FFS::FLUID_HINT_BOUNDED_ABOVE
    exp = 0x2
    assert_equal exp, ret

    ret = FFS::FLUID_HINT_BOUNDED_BELOW
    exp = 0x1
    assert_equal exp, ret

    ret = FFS::FLUID_HINT_OPTIONLIST
    exp = 0x02
    assert_equal exp, ret

    ret = FFS::FLUID_HINT_TOGGLED
    exp = 0x4
    assert_equal exp, ret

  end

  #
  test "Settings - Constants: Enumerations" do

    #
    ret = FFS::Enum_fluid_types_enum
    exp = FFS::Enum_fluid_types_enum
    assert_equal exp, ret

    ret = FFS::FLUID_NO_TYPE
    exp = FFS::Enum_fluid_types_enum::FLUID_NO_TYPE
    assert_equal exp, ret

    tmp = [
      FFS::FLUID_NO_TYPE,
      FFS::FLUID_NUM_TYPE,
      FFS::FLUID_INT_TYPE,
      FFS::FLUID_STR_TYPE,
      FFS::FLUID_SET_TYPE,
    ]
    ret = tmp
    exp = (-1...4).to_a
    assert_equal exp, ret

  end


end

#
#
#
class FiddleFluidSynth::SettingsTest

  #
  #
  #
  test "Settings - Lifecycle" do

    # settings = FFS.settings_new
    # settings.midi_driver = "coremidi"   # macOS.

    #
    tmp = FFS.settings_new
    # $stderr.puts "  {#{description}} MIDI driver instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.settings_delete(tmp)

  end


  #
  test "Settings - settings" do

    settings = FFS.settings_new
    # settings.midi_driver = "coremidi"   # macOS.

    # char** =>.ptr.to_s
    out = Fiddle::Pointer.malloc_voidp
    tmp = FFS.settings_dupstr(settings: settings, name: 'midi.driver',
                              out: out)
    $stderr.puts "  {#{description}} out: #{out.ptr.to_s}"

    #
    ret = out.ptr.to_s
    exp = "coremidi"
    assert_equal exp, ret

    ret = tmp
    exp = "coremidi"
    assert_equal exp, ret

    # by getters.
    ret = settings.audio_driver
    exp = "coreaudio"
    assert_equal exp, ret

    ret = settings.midi_driver
    exp = "coremidi"
    assert_equal exp, ret

    #
    FFS.settings_delete(settings)

  end


end


#
#
#
class FiddleFluidSynth::SettingsTest

  test "Settings  - item_to_meth_name" do
    #
    settings = FFS.settings_new

    #
    ret = FFS.settings_item_to_meth_name("audio.driver")
    exp = "audio_driver"
    assert_equal exp, ret

    #
    ret = FFS::Interface::Settings.item_to_meth_name("audio.driver")
    exp = "audio_driver"
    assert_equal exp, ret

    #
    ret = settings.item_to_meth_name("audio.driver")
    exp = "audio_driver"
    assert_equal exp, ret

    ret = settings.item_to_meth_name("audio.period-size")
    exp = "audio_period__size"
    assert_equal exp, ret

    ret = settings.audio_driver
    exp = "coreaudio"
    assert_equal exp, ret

    ret = settings.audio_period__size
    exp = 64
    assert_equal exp, ret

    #
    ret = settings.val_of("audio.driver")
    exp = "coreaudio"
    assert_equal exp, ret

    ret = settings.val_of("audio.period-size")
    exp = 64
    assert_equal exp, ret


    #
    FFS.settings_delete(settings)
  end

  #
  test "Settings  - methods" do
    #
    settings = FFS.settings_new

    #
    tmp = settings.type_of('audio.driver')
    ret = tmp
    exp = 2
    assert_equal exp, ret

    ret = FFS.setting_type_is_notype?(tmp)
    exp = false
    assert_equal exp, ret
    ret = FFS.setting_type_is_num?(tmp)
    exp = false
    assert_equal exp, ret
    ret = FFS.setting_type_is_int?(tmp)
    exp = false
    assert_equal exp, ret
    ret = FFS.setting_type_is_str?(tmp)
    exp = true
    assert_equal exp, ret
    ret = FFS.setting_type_is_set?(tmp)
    exp = false
    assert_equal exp, ret

    ret = settings.type_is_str?('audio.driver')
    exp = true
    assert_equal exp, ret


    #
    ret = settings.hints_of('audio.driver')
    exp = 2
    assert_equal exp, ret

    ret = FFS.setting_hints_is_bounded_above?(tmp)
    exp = true
    assert_equal exp, ret
    ret = FFS.setting_hints_is_bounded_below?(tmp)
    exp = false
    assert_equal exp, ret
    ret = FFS.setting_hints_is_optionlist?(tmp)
    exp = true
    assert_equal exp, ret
    ret = FFS.setting_hints_is_toggled?(tmp)
    exp = false
    assert_equal exp, ret

    ret = settings.hints_is_bounded_above?('audio.driver')
    exp = true
    assert_equal exp, ret
    ret = settings.hints_is_bounded_below?('audio.driver')
    exp = false
    assert_equal exp, ret
    ret = settings.hints_is_optionlist?('audio.driver')
    exp = true
    assert_equal exp, ret
    ret = settings.hints_is_toggled?('audio.driver')
    exp = false
    assert_equal exp, ret


    FFS.settings_delete(settings)
  end

  # we have to create FFS to test `is_realtime?` because settings_is_realtime()
  # needs to be connected to all system for working.
  # See API Reference.
  #
  test "Settings  - #is_realtime?" do
    ffs = FFS.new

    ret = ffs.settings.is_realtime?('player.reset-synth')
    exp = true
    assert_equal exp, ret

    ret = ffs.settings.is_realtime?('audio.driver')
    exp = false
    assert_equal exp, ret

  end

end


#### endof filename: settings/settings_test.rb
