#!/usr/bin/env ruby
#
#

# Original comments:
# FluidSynth Metronome - Sequencer API example
#
# This code is in the public domain.
#
# To compile:
#   gcc -o fluidsynth_metronome -lfluidsynth fluidsynth_metronome.c
#
# To run:
#   fluidsynth_metronome soundfont [beats [tempo]]
#
# [Pedro Lopez-Cabanillas <plcl@users.sf.net>]

# fiddle_fluidsynth comments:
# `ffs_metronome.rb` is FiddleFluidSynth version of `fluidsynth_metronome.c`.
# This code is also in the public domain.
#
# [YAMAMOTO, Masayuki, ]

#
require_relative '../lib/fiddle_fluidsynth'
# require 'fiddle_fluidsynth'


#
# @audiodriver = nil
@seq   = nil

#
@synth_dest, @client_dest = nil, nil
@time_marker = nil

# default tempo, beats per minute.
TEMPO = 120
tempo = TEMPO
@note_duration = 60000 / TEMPO

# metronome click/bell.
@weak_note   = 33   # click sound.
@strong_note = 34   # click+bell sound.

# number of notes in one pattern (beats).
@pattern_size = 4


# schedule a note on message.
#
#
FFS = FiddleFluidSynth
def schedule_noteon( ch, key, ticks )

  # ev = FFS.event_new
  # ev.set_type(:noteon, ch: ch, key: key, vel: 127)
  # :
  # FFS.event_delete(ev)
  FFS.seq_event(:noteon, ch: ch, key: key, vel: 127){|ev|
    ev.source = -1
    ev.dest   = @synth_dest

    #
    if @seq.send_at(event: ev, time: ticks, absolute: 1) == \
        FFS::FLUID_FAILED
      $stderr.puts "(**) {#{__method__}} seq. send_at() failed."
    end
    # if FFS::FLUID_FAILED == _tmp
    #   $stderr.puts "(**) {#{__method__}} seq. send_at() failed (#{_tmp})."
    # else
    #   $stderr.puts "(**) {#{__method__}} seq. send_at() succeeded (#{_tmp})."
    # end
  }

end


# schedule a timer event (shall trigger the callback).
#
#
def schedule_timer_event

  # $stderr.puts "{#{__method__}} Scheduling timer event at #{@time_marker}"
  # $stderr.puts "  Current tick: #{@seq.tick}"

  #ev = FFS.event_new
  # FFS.event_set_src(ev, src: -1)
  # FFS.event_set_dest(ev, dest: @client_dest)
  # FFS.event_timer(ev, data: nil)
  #ev.set_type(:timer, data: nil)
  # :
  #FFS.event_delete(ev)
  FFS.seq_event(:timer, data: nil){|ev|
    ev.source = -1
    ev.dest   = @client_dest
    # $stderr.puts "{#{__method__}} set as a timer event for #{ev.inspect}"

    if @seq.send_at(event: ev, time: @time_marker, absolute: 1) == \
        FFS::FLUID_FAILED
      $stderr.puts "(**) {#{__method__}} seq. send_at() failed."
    end
    # if FFS::FLUID_FAILED == _tmp
    #   $stderr.puts "(**) {#{__method__}} seq. send_at() failed (#{_tmp})."
    # else
    #   $stderr.puts "(**) {#{__method__}} seq. send_at() succeeded (#{_tmp})."
    # end
  }

end


# schedule the metronome pattern.
#
#
def schedule_pattern
  # $stderr.puts "{#{__method__}} Scheduling pattern events at #{@time_marker}"
  # $stderr.puts "  Current tick: #{@seq.tick}"

  #
  note_time = @time_marker

  #
  # @pattern_size.times do |_i|
  (0...@pattern_size).each do |_i|
    # 0 is also true in Ruby... so we have to change the logic.
    _note = !(_i.zero?) ? @weak_note : @strong_note
    $stderr.puts "  #{_note}, scheduled at note_time: #{note_time}" if \
      ARGV.size == 4

    schedule_noteon(9, _note, note_time)
    note_time += @note_duration
  end

  @time_marker = note_time
  # $stderr.puts "{#{__method__}} Next time marker: #{@time_marker}"
end

#
@seq_cb_ptr = FFS.define_event_callback{|time, ev, seq, data|
  # $stderr.puts "{#{Time.now}} on callback."
  schedule_timer_event()
  schedule_pattern()
}

#
def usage( prog_name = __FILE__ )
  puts "Usage: #{prog_name} [soundfont] [beats [tempo]]"
  puts "   or  #{prog_name} -h"
  puts "\tsoundfont [optional]: soundfont file name (in full path)," +
    " default #{FFS.obtain_full_path_for_soundfont}."
  puts "\tbeats [optional]:     number of pattern beats, default #{@pattern_size}"
  puts "\ttempo [optional]:     BPM (Beats Per Minute), default #{TEMPO}"
end


### main.

if ARGV[0] == '-h' || ARGV[0] == '--help'
  usage()
  exit 1
end

#
opt_idx = 0
fs =  if File.exist?("#{ARGV[opt_idx]}")
        tmp = FiddleFluidSynth.new(
                soundfont_full_path: "#{ARGV[opt_idx]}", player_f: false)
        opt_idx += 1
        $stderr.puts "(1) opt_idx: #{opt_idx}"
        tmp
      else
        $stderr.puts "(2) opt_idx: #{opt_idx}"
        FiddleFluidSynth.new(player_f: false)
      end
$stderr.puts "opt_idx: #{opt_idx}"

#
# @seq   = fs.sequencer_new2(0)
@seq   = fs.sequencer_new2
if @seq.null?
  raise "Cannot prepare the sequencer!"
end
puts "seq. clients: #{@seq.count_clients}"


# register the synthesizer (automatically destination)
# to the sequencer.
#
@synth_dest  = @seq.register_fluidsynth(fs.synth)
if FFS::FLUID_FAILED == @synth_dest
  raise "Client (synth) registsteration failed."
end
puts "seq_id: #{@synth_dest}, seq. clients: #{@seq.count_clients}"


# register the sequencer client.
#
#
@client_dest = @seq.register_client(
                 name: 'ffs_metronome',
                 event_callback: @seq_cb_ptr, data: nil)
if FFS::FLUID_FAILED == @client_dest
  raise "Client registsteration failed."
end
puts "seq_id: #{@client_dest}, seq. clients: #{@seq.count_clients}"


# If we prepare the audio driver twice, note_duration become half.
# I dont know why...
#
# @audiodriver = fs.audio_driver_prepare

#
#if ARGV.size >= 2 && ARGV[opt_idx]
if ARGV.size >= 1 && ARGV[opt_idx]
  $stderr.puts "(**) beats setting (#ARGV: #{ARGV.size}, opt_idx: #{opt_idx})."
  beats = ARGV[opt_idx].to_i
  opt_idx += 1
  $stderr.puts "(**) beats is set to: #{beats}."
  @pattern_size = beats if beats > 0
end

#
if ARGV.size >= 2 && ARGV[opt_idx]
  $stderr.puts "(**) tempo setting (#ARGV: #{ARGV.size}, opt_idx: #{opt_idx})."
  tempo = ARGV[opt_idx].to_i
  opt_idx += 1
  @note_duration = 60000/tempo if tempo > 0
  $stderr.puts "(**) tempo is set to #{tempo}."
end

# get the current time in ticks.
#
#
# @time_marker = fs.sequencer_get_tick(@seq)
@time_marker = @seq.tick

# schedule patterns.
schedule_pattern()
schedule_timer_event()
schedule_pattern()

# wait for user input.
#
#
puts "beats: #{@pattern_size}/tempo: #{tempo}" +
  " =>note_duration: #{@note_duration} [ms]"
print 'Press "Enter" to stop: '
$stdin.getc
fs.raise_error_in_callback
puts "done."

#
puts "Cleaning up..."
fs.delete
puts "fs.deleted."

puts "Done. Exiting program."
#### end.
