# frozen_string_literal: true
#
# filename: sequencer/sequencer_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::SequencerTest < Test::Unit::TestCase

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
class FiddleFluidSynth::SequencerTest

  #
  #
  #
  test "Sequencer/top - Lifecycle" do

    #
    tmp = FFS.sequencer_new2(0)
    $stderr.puts "  {#{description}} seq. event instance:" +
      " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    ret = FFS.sequencer_get_use_system_timer(tmp)
    exp = 0
    assert_equal exp, ret

    ret = FFS.sequencer_use_system_timer?(tmp)
    exp = false
    assert_equal exp, ret

    ret = FFS.sequencer_nouse_system_timer?(tmp)
    exp = true
    assert_equal exp, ret

    ### clients.
    seq_id1 = FFS.sequencer_register_client(
                tmp, name: 'client1', event_callback: nil, data: nil)
    ret = seq_id1
    exp = 1
    assert_equal exp, ret

    seq_id2 = tmp.register_client(
                name: 'client 2', event_callback: nil, data: nil)
    ret = seq_id2
    exp = 2
    assert_equal exp, ret

    ret = FFS.sequencer_count_clients(tmp)
    exp = 2
    assert_equal exp, ret

    #
    ret = FFS.sequencer_get_client_name(tmp, seq_id: 1)
    exp = "client1"
    assert_equal exp, ret

    ret = FFS.sequencer_get_client_name(tmp, seq_id: 2)
    exp = "client 2"
    assert_equal exp, ret

    #
    tmp_ary = []
    tmp.each_client_id{|cli_id|
      tmp_ary << tmp.client_name(seq_id: cli_id)
    }
    ret = tmp_ary
    exp = ["client1", "client 2"]
    assert_equal exp, ret


    #
    FFS.sequencer_unregister_client(tmp, seq_id: 2)
    ret = FFS.sequencer_count_clients(tmp)
    exp = 1
    assert_equal exp, ret



    #
    FFS.sequencer_delete(tmp)

  end

  #
  test "Sequencer/top - Lifecycle (old)" do

    #
    tmp = FFS.sequencer_new
    $stderr.puts "  {#{description}} seq. event instance:" +
      " 0x#{tmp.to_i.to_s(16)}"

    #
    ret = !(tmp.nil?)
    exp = true
    assert_equal exp, ret

    ret = !(tmp.null?)
    exp = true
    assert_equal exp, ret

    #
    ret = FFS.sequencer_get_use_system_timer(tmp)
    exp = 1
    assert_equal exp, ret

    ret = FFS.sequencer_use_system_timer?(tmp)
    exp = true
    assert_equal exp, ret

    ret = FFS.sequencer_nouse_system_timer?(tmp)
    exp = false
    assert_equal exp, ret

    #
    FFS.sequencer_delete(tmp)

  end

  #
  #
  #
  test "Sequencer/Events - Lifecycle" do

    #
    tmp = FFS.event_new
    $stderr.puts "  {#{description}} seq. event instance:" +
      " 0x#{tmp.to_i.to_s(16)}"

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
class FiddleFluidSynth::SequencerTest

  #
  #
  #
  test "Sequencer/top - getters/setters." do

    #
    tmp = FFS.sequencer_new2(0)

    #
    ret = tmp.client_is_dest(seq_id: -1)
    exp = 0
    assert_equal exp, ret

    ret = tmp.is_dest?(seq_id: -1)
    exp = false
    assert_equal exp, ret

    #
    ret = tmp.count_clients()
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.client_name(seq_id: 0)
    exp = nil
    assert_equal exp, ret

    #
    ret = tmp.client_id(index: 0)
    exp = -1
    assert_equal exp, ret

    ### with the clients.
    settings = FFS.settings_new()
    synth    = FFS.synth_new(settings)

    # seq_id1  = tmp.register_fluidsynth(synth: synth)
    seq_id1  = tmp.register_fluidsynth(synth)
    seq_id2  = tmp.register_client(
                 name: 'client 2', event_callback: nil, data: nil)

    ret = [seq_id1, seq_id2]
    exp = [1, 2]
    assert_equal exp, ret

    ret = tmp.client_is_dest(seq_id: seq_id1)
    exp = 1
    assert_equal exp, ret

    ret = tmp.is_dest?(seq_id: seq_id1)
    exp = true
    assert_equal exp, ret

    ret = tmp.client_is_dest(seq_id: seq_id2)
    exp = 0
    assert_equal exp, ret

    ret = tmp.is_dest?(seq_id: seq_id2)
    exp = false
    assert_equal exp, ret

    #
    ret = tmp.count_clients()
    exp = 2
    assert_equal exp, ret

    #
    ret = tmp.client_name(seq_id: seq_id1)
    exp = "fluidsynth"
    assert_equal exp, ret

    #
    ret = tmp.client_id(index: 0)
    exp = 1
    assert_equal exp, ret

    ret = tmp.client_id(index: 1)
    exp = 2
    assert_equal exp, ret

    ret = tmp.time_scale
    exp = 1000.0
    assert_equal exp, ret

    ret = tmp.time_scale=(512.3)
    exp = 512.3
    assert_equal exp, ret

    ret = tmp.time_scale()
    exp = 512.3
    assert_equal exp, ret

    #
    ret = tmp.tick()
    exp = 0
    assert_equal exp, ret

    #
    ret = tmp.use_system_timer
    exp = 0
    assert_equal exp, ret

    ret = tmp.use_system_timer?
    exp = false
    assert_equal exp, ret


  end

end



#### endof filename: sequencer/sequencer_test.rb
