# frozen_string_literal: true
#
# filename: midi_input/midi_input_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::MIDIInputTest < Test::Unit::TestCase

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
class FiddleFluidSynth::MIDIInputTest

  #
  #
  #
  test "MIDIInput - top" do

    #

  end


end

#
#
#
class FiddleFluidSynth::MIDIInputTest

  #
  #
  #
  test "MIDIInput - Driver" do

    settings = FFS.settings_new
    # settings.midi_driver = "coremidi"   # macOS.

    #
    cb_ptr = FFS::Midi_router_handle_midi_event_default
    tmp = FFS.midi_driver_new(settings: settings,
                              handler: cb_ptr, handler_data: nil)
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
    FFS.midi_driver_delete(tmp)
    FFS.settings_delete(settings)

  end

  #
  test "MIDIInput - Driver (w/o callback, i.e., invalid argument.)" do

    settings = FFS.settings_new

    ### Invalid argument.

    # to avoid the msg: `fluidsynth: error: Invalid argument`,
    # redirect it to /dev/null.
    #
    cb_ptr = nil
    tmp = stderr_to_devnull{
      FFS.midi_driver_new(settings: settings,
                          handler: cb_ptr, handler_data: nil)
    }

    # $stderr.puts "  {#{description}} MIDI driver instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    # NULL pointer.
    ret = !(tmp.null?)
    exp = false
    assert_equal exp, ret

    #
    FFS.midi_driver_delete(tmp)
    FFS.settings_delete(settings)

  end


end


# MIDI Event.
#
#
class FiddleFluidSynth::MIDIInputTest

  #
  #
  #
  test "MIDIInput - Event" do

    settings = FFS.settings_new
    # settings.midi_driver = "coremidi"   # macOS.

    #
    tmp = FFS.midi_event_new()
    # $stderr.puts "  {#{description}} MIDI event instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.midi_event_delete(tmp)
    FFS.settings_delete(settings)

  end


end


# MIDI File Player.
#
#
class FiddleFluidSynth::MIDIInputTest

  #
  #
  #
  test "MIDIInput - File Player" do

    settings = FFS.settings_new
    synth    = FFS.synth_new(settings)
    # settings.midi_driver = "coremidi"   # macOS.

    #
    tmp = FFS.player_new(synth)
    # $stderr.puts "  {#{description}} MIDI file player instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.player_delete(tmp)
    FFS.synth_delete(synth)
    FFS.settings_delete(settings)

  end

  #
  test "MIDIInput - File Player: Constants" do
    ret = FFS::Enum_fluid_player_set_tempo_type
    exp = FFS::Enum_fluid_player_set_tempo_type
    assert_equal exp, ret

    tmp = [ FFS::FLUID_PLAYER_TEMPO_INTERNAL,
            FFS::FLUID_PLAYER_TEMPO_EXTERNAL_BPM,
            FFS::FLUID_PLAYER_TEMPO_EXTERNAL_MIDI,
            FFS::FLUID_PLAYER_TEMPO_NBR, ]
    ret = tmp
    exp = (0...4).map{|i| i }
    assert_equal exp, ret

    #
    ret = FFS::Enum_fluid_player_status
    exp = FFS::Enum_fluid_player_status
    assert_equal exp, ret

    tmp = [ FFS::FLUID_PLAYER_READY,
            FFS::FLUID_PLAYER_PLAYING,
            FFS::FLUID_PLAYER_STOPPING,
            FFS::FLUID_PLAYER_DONE, ]
    ret = tmp
    exp = (0...4).map{|i| i }
    assert_equal exp, ret

  end


end


# MIDI Router.
#
#
class FiddleFluidSynth::MIDIInputTest

  #
  #
  #
  test "MIDIInput - Router" do

    settings = FFS.settings_new
    # settings.midi_driver = "coremidi"   # macOS.

    #
    cb_ptr = FFS::Synth_handle_midi_event_default
    tmp = FFS.midi_router_new(settings: settings,
                              handler: cb_ptr, handler_data: nil)
    # $stderr.puts "  {#{description}} MIDI router instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    #ng. FFS.player_delete(tmp)  #ng. naturally.
    FFS.midi_router_delete(tmp)
    FFS.settings_delete(settings)

  end

  #
  #
  #
  test "MIDIInput - Router Rule" do

    #
    tmp = FFS.midi_router_rule_new()
    # $stderr.puts "  {#{description}} MIDI router rule instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.midi_router_rule_delete(tmp)

  end

  #
  test "MIDIInput - Router: Constants" do
    ret = FFS::Enum_fluid_midi_router_rule_type
    exp = FFS::Enum_fluid_midi_router_rule_type
    assert_equal exp, ret

    tmp = [ FFS::FLUID_MIDI_ROUTER_RULE_NOTE,
            FFS::FLUID_MIDI_ROUTER_RULE_CC,
            FFS::FLUID_MIDI_ROUTER_RULE_PROG_CHANGE,
            FFS::FLUID_MIDI_ROUTER_RULE_PITCH_BEND,
            FFS::FLUID_MIDI_ROUTER_RULE_CHANNEL_PRESSURE,
            FFS::FLUID_MIDI_ROUTER_RULE_KEY_PRESSURE,
            FFS::FLUID_MIDI_ROUTER_RULE_COUNT, ]
    ret = tmp
    exp = (0...7).map{|i| i }
    assert_equal exp, ret

  end


end


#### endof filename: midi_input/midi_input_test.rb
