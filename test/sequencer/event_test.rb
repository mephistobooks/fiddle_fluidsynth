# frozen_string_literal: true
#
# filename: sequencer/event_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::SequencerEventTest < Test::Unit::TestCase

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
#
#
class FiddleFluidSynth::SequencerEventTest

  #
  #
  #
  test "SequencerEvents - Constants: Enumerations" do

    #
    ret = FFS::Enum_fluid_seq_event_type
    exp = FFS::Enum_fluid_seq_event_type
    assert_equal exp, ret

    ret = FFS::FLUID_NO_TYPE
    exp = FFS::Enum_fluid_types_enum::FLUID_NO_TYPE
    assert_equal exp, ret

    tmp = [
      FFS::FLUID_SEQ_NOTE,
      FFS::FLUID_SEQ_NOTEON,
      FFS::FLUID_SEQ_NOTEOFF,
      FFS::FLUID_SEQ_ALLSOUNDSOFF,
      FFS::FLUID_SEQ_ALLNOTESOFF,
      FFS::FLUID_SEQ_BANKSELECT,
      FFS::FLUID_SEQ_PROGRAMCHANGE,
      FFS::FLUID_SEQ_PROGRAMSELECT,
      FFS::FLUID_SEQ_PITCHBEND,
      FFS::FLUID_SEQ_PITCHWHEELSENS,
      FFS::FLUID_SEQ_MODULATION,
      FFS::FLUID_SEQ_SUSTAIN,
      FFS::FLUID_SEQ_CONTROLCHANGE,
      FFS::FLUID_SEQ_PAN,
      FFS::FLUID_SEQ_VOLUME,
      FFS::FLUID_SEQ_REVERBSEND,
      FFS::FLUID_SEQ_CHORUSSEND,
      FFS::FLUID_SEQ_TIMER,
      FFS::FLUID_SEQ_CHANNELPRESSURE,
      FFS::FLUID_SEQ_KEYPRESSURE,
      FFS::FLUID_SEQ_SYSTEMRESET,
      FFS::FLUID_SEQ_UNREGISTERING,
      FFS::FLUID_SEQ_SCALE,
      FFS::FLUID_SEQ_LASTEVENT,
    ]
    ret = tmp
    exp = (0...(tmp.size)).to_a
    assert_equal exp, ret

  end

end


#
#
#
class FiddleFluidSynth::SequencerEventTest

  #
  #
  #
  test "SequencerEvents - Lifecycle" do

    #
    tmp = FFS.event_new
    # $stderr.puts "  {#{description}} seq. event instance:" +
    #   " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    FFS.event_delete(tmp)

  end


end


#
#
#
class FiddleFluidSynth::SequencerEventTest

  #
  #
  #
  test "SequencerEvents - getters only" do

    #
    tmp = FFS.event_new

    #
    ret = tmp.bank
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.channel
    exp = 0
    assert_equal exp, ret

    ret = tmp.ch
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.control
    exp = 0
    assert_equal exp, ret

    ret = tmp.ctrl
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.data.null?
    exp = true
    assert_equal exp, ret

    #
    # ret = tmp.dest
    # exp = 0
    # assert_equal exp, ret

    #
    ret = tmp.duration
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.key
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.pitch
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.program
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.scale
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.sfont_id
    exp = 0
    assert_equal exp, ret

    ret = tmp.sfid
    exp = 0
    assert_equal exp, ret

    #
    # ret = tmp.source
    # exp = 0
    # assert_equal exp, ret

    #
    ret = tmp.type
    exp = -1  # -1 means NO_TYPE.?
    assert_equal exp, ret

    #
    ret = tmp.value
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.velocity
    exp = 0
    assert_equal exp, ret

    ret = tmp.vel
    exp = 0
    assert_equal exp, ret

    ret = tmp.velc
    exp = 0
    assert_equal exp, ret


    #
    FFS.event_delete(tmp)

  end

  #
  #
  #
  test "SequencerEvents - getters+setters" do

    #
    tmp = FFS.event_new

    ### destination.
    ret = tmp.dest
    exp = -1
    assert_equal exp, ret

    #
    tmp.dest = 123
    ret = tmp.dest
    exp = 123
    assert_equal exp, ret

    #
    ret = tmp.src
    exp = -1
    assert_equal exp, ret

    ### source.
    ret = tmp.source
    exp = -1
    assert_equal exp, ret

    #
    tmp.source = 321
    ret = tmp.source
    exp = 321
    assert_equal exp, ret


    #
    FFS.event_delete(tmp)

  end

end


#
#
#
class FiddleFluidSynth::SequencerEventTest

  #
  #
  #
  test "SequencerEvents - getters+setters (Event Type)" do

    #
    tmp = FFS.event_new

    ret = tmp.type
    exp = -1    # initial value.
    assert_equal exp, ret

    #
    tmp.set_type(:note, ch: 1, key: 2, vel: 3, duration: 4)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_NOTE
    assert_equal exp, ret

    ret = tmp.ch
    exp = 1
    assert_equal exp, ret

    ret = tmp.key
    exp = 2
    assert_equal exp, ret

    ret = tmp.vel
    exp = 3
    assert_equal exp, ret

    ret = tmp.duration
    exp = 4
    assert_equal exp, ret

    # FFS.event_noteon(tmp, ch: 9, key: 33, vel: 80)
    tmp.set_type(:noteon, ch: 2, key: 4, vel: 5)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_NOTEON
    assert_equal exp, ret

    ret = tmp.ch
    exp = 2
    assert_equal exp, ret

    ret = tmp.key
    exp = 4
    assert_equal exp, ret

    ret = tmp.velc
    exp = 5
    assert_equal exp, ret

    #
    tmp.set_type(:noteoff, ch: 3, key: 5)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_NOTEOFF
    assert_equal exp, ret

    ret = tmp.ch
    exp = 3
    assert_equal exp, ret

    ret = tmp.key
    exp = 5
    assert_equal exp, ret

    #
    tmp.set_type(:all_sounds_off, ch: 4)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_ALLSOUNDSOFF
    assert_equal exp, ret

    ret = tmp.ch
    exp = 4
    assert_equal exp, ret

    #
    tmp.set_type(:all_notes_off, ch: 5)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_ALLNOTESOFF
    assert_equal exp, ret

    ret = tmp.ch
    exp = 5
    assert_equal exp, ret

    #
    tmp.set_type(:bank_select, ch: 6, bknum: 7)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_BANKSELECT
    assert_equal exp, ret

    ret = tmp.ch
    exp = 6
    assert_equal exp, ret

    ret = tmp.bknum
    exp = 7
    assert_equal exp, ret

    #
    tmp.set_type(:program_change, ch: 7, prenum: 8)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_PROGRAMCHANGE
    assert_equal exp, ret

    ret = tmp.ch
    exp = 7
    assert_equal exp, ret

    ret = tmp.prenum
    exp = 8
    assert_equal exp, ret

    ret = tmp.pgnum
    exp = 8
    assert_equal exp, ret

    #
    tmp.set_type(:program_select, ch: 8, sfid: 1, bknum: 2, pgnum: 3)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_PROGRAMSELECT
    assert_equal exp, ret

    ret = tmp.ch
    exp = 8
    assert_equal exp, ret

    ret = tmp.sfid
    exp = 1
    assert_equal exp, ret

    ret = tmp.bknum
    exp = 2
    assert_equal exp, ret

    ret = tmp.pgnum
    exp = 3
    assert_equal exp, ret

    #
    tmp.set_type(:pitch_bend, ch: 9, pitch: 1000)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_PITCHBEND
    assert_equal exp, ret

    ret = tmp.ch
    exp = 9
    assert_equal exp, ret

    ret = tmp.pitch  # NOT `#value`
    exp = 1000
    assert_equal exp, ret

    #
    tmp.set_type(:pitch_wheelsens, ch: 10, val: 1001)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_PITCHWHEELSENS
    assert_equal exp, ret

    ret = tmp.ch
    exp = 10
    assert_equal exp, ret

    ret = tmp.value
    exp = 1001
    assert_equal exp, ret

    #
    tmp.set_type(:modulation, ch: 11, val: 22)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_MODULATION
    assert_equal exp, ret

    ret = tmp.ch
    exp = 11
    assert_equal exp, ret

    ret = tmp.val
    exp = 22
    assert_equal exp, ret

    ### .

    #
    tmp.set_type(:sustain, ch: 12, val: 34)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_SUSTAIN
    assert_equal exp, ret

    ret = tmp.ch
    exp = 12
    assert_equal exp, ret

    ret = tmp.val
    exp = 34
    assert_equal exp, ret

    #
    tmp.set_type(:control_change, ch: 13, ctrl: 4, val: 56)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_CONTROLCHANGE
    assert_equal exp, ret

    ret = tmp.ch
    exp = 13
    assert_equal exp, ret

    ret = tmp.ctrl
    exp = 4
    assert_equal exp, ret

    ret = tmp.val
    exp = 56
    assert_equal exp, ret

    #
    tmp.set_type(:pan, ch: 14, val: 56)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_PAN
    assert_equal exp, ret

    ret = tmp.ch
    exp = 14
    assert_equal exp, ret

    ret = tmp.val
    exp = 56
    assert_equal exp, ret

    #
    tmp.set_type(:volume, ch: 15, val: 67)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_VOLUME
    assert_equal exp, ret

    ret = tmp.ch
    exp = 15
    assert_equal exp, ret

    ret = tmp.value
    exp = 67
    assert_equal exp, ret

    #
    tmp.set_type(:reverb_send, ch: 16, val: 78)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_REVERBSEND
    assert_equal exp, ret

    ret = tmp.ch
    exp = 16
    assert_equal exp, ret

    ret = tmp.value
    exp = 78
    assert_equal exp, ret

    #
    tmp.set_type(:chorus_send, ch: 17, val: 89)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_CHORUSSEND
    assert_equal exp, ret

    ret = tmp.ch
    exp = 17
    assert_equal exp, ret

    ret = tmp.value
    exp = 89
    assert_equal exp, ret

    #
    # tmp.set_type(:timer, data: 33)
    tmp.set_type(:timer, data: "test")
    ret = tmp.type
    exp = FFS::FLUID_SEQ_TIMER
    assert_equal exp, ret

    ret = tmp.data.to_s
    exp = "test"
    assert_equal exp, ret

    #
    tmp.set_type(:channel_pressure, ch: 19, val: 10)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_CHANNELPRESSURE
    assert_equal exp, ret

    ret = tmp.ch
    exp = 19
    assert_equal exp, ret

    ret = tmp.val
    exp = 10
    assert_equal exp, ret

    #
    tmp.set_type(:key_pressure, ch: 21, key: 22, val: 23)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_KEYPRESSURE
    assert_equal exp, ret

    ret = tmp.ch
    exp = 21
    assert_equal exp, ret

    ret = tmp.key
    exp = 22
    assert_equal exp, ret

    ret = tmp.value
    exp = 23
    assert_equal exp, ret

    #
    tmp.set_type(:system_reset)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_SYSTEMRESET
    assert_equal exp, ret

    #
    tmp.set_type(:unregistering)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_UNREGISTERING
    assert_equal exp, ret

    #
    tmp.set_type(:scale, scale: 2.0)
    ret = tmp.type
    exp = FFS::FLUID_SEQ_SCALE
    assert_equal exp, ret

    ret = tmp.scale
    exp = 2.0
    assert_equal exp, ret


    ### shortcuts.

    # tmp.scale=(scale: 2.0)
    # tmp.scale=(scale: 2.0)
    tmp.set_scale(1.234)
    ret = tmp.scale
    exp = 1.234
    assert_equal exp, ret


    #
    FFS.event_delete(tmp)

  end


end



#### endof filename: sequencer/event_test.rb
