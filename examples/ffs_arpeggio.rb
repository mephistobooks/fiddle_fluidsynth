#!/usr/bin/env ruby
#
#

# Original comments:
# FluidSynth Arpeggio - Sequencer API example
#
# This code is in the public domain.
#
# To compile:
#   gcc -o fluidsynth_arpeggio -lfluidsynth fluidsynth_arpeggio.c
#
# To run:
#   fluidsynth_arpeggio soundfont [steps [duration]]
#
# [Pedro Lopez-Cabanillas <plcl@users.sf.net>]

# fiddle_fluidsynth comments:
# `ffs_arpeggio.rb` is fiddle_fluidsynth version of `fluidsynth_arpeggio.c`.
# This code is also in the public domain.
#
# [YAMAMOTO, Masayuki, https://github.com/mephistobooks]

#
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


#
FFS  = FiddleFluidSynth
@seq = nil

#
@synth_dest, @client_dest = nil, nil
@time_marker = nil

# duration of the pattern in ticks.
@duration = 1440

# notes of the arpeggio.
@notes = [ 60, 64, 67, 72, 76, 79, 84, 79, 76, 72, 67, 64, ]

# number of notes in one pattern.
@pattern_size = 4


### schedule a note on message.
def schedule_noteon( ch, key, ticks )

  # ev = FFS.event_new
  FFS.seq_event(:noteon, ch: ch, key: key, vel: 127){|ev| 
    # FFS.event_set_src(ev, src: -1)
    # FFS.event_set_dest(ev, dest: @synth_dest)
    ev.src = -1
    ev.dst = @synth_dest
    # ev.noteon(ch: ch, key: key, vel: 127)
    # tmp = @seq.send_at(event: ev, time: ticks, absolute: 1)
    if @seq.send_at(event: ev, time: ticks, absolute: 1) == FFS::FLUID_FAILED
      $stderr.puts "(**) {#{__method__}} seq. send_at(): failed."
    end

    #if FFS::FLUID_FAILED == tmp
    #  $stderr.puts "(**) {#{__method__}} seq. send_at(): failed (#{tmp})."
    #else
    #  $stderr.puts "(**) {#{__method__}} seq. send_at(): succeeded (#{tmp})."
    #end
    # FFS.event_delete(ev)
  }

end

### schedule a note off message.
def schedule_noteoff( ch, key, ticks )

  # ev = FFS.event_new
  FFS.seq_event(:noteoff, ch: ch, key: key){|ev|
    # FFS.event_set_src(ev, src: -1)
    # FFS.event_set_dest(ev, dest: @synth_dest)
    # FFS.event_noteoff(ev, ch: ch, key: key)
    ev.src = -1
    ev.dst = @synth_dest
    # ev.noteoff(ch: ch, key: key)
    # tmp = FFS.sequencer_send_at(@seq, event: ev, time: ticks, absolute: 1)
    # tmp = @seq.send_at(event: ev, time: ticks, absolute: 1)
    if @seq.send_at(event: ev, time: ticks, absolute: 1) == FFS::FLUID_FAILED
      $stderr.puts "(**) {#{__method__}} seq. send_at(): failed."
    end

    # if FFS::FLUID_FAILED == tmp
    #   $stderr.puts "(**) {#{__method__}} seq. send_at(): failed (#{tmp})."
    # else
    #   $stderr.puts "(**) {#{__method__}} seq. send_at(): succeeded (#{tmp})."
    # end
    # FFS.event_delete(ev)
  }

end

# schedule a timer event (shall trigger the callback).
#
#
def schedule_timer_event

  # ev = FFS.event_new
  FFS.seq_event(:timer, data: nil){|ev|
    # FFS.event_set_src(ev, src: -1)
    # FFS.event_set_dest(ev, dest: @client_dest)
    # FFS.event_timer(ev, data: nil)
    ev.src = -1
    ev.dst = @client_dest
    # ev.timer(data: nil)

    # tmp = FFS.sequencer_send_at(@seq, event: ev, time: @time_marker, absolute: 1)
    # tmp = @seq.send_at(event: ev, time: @time_marker, absolute: 1)
    if @seq.send_at(event: ev, time: @time_marker, absolute: 1) == \
      FFS::FLUID_FAILED
      $stderr.puts "(**) {#{__method__}} seq. send_at(): failed (#{tmp})."
    end

    # if FFS::FLUID_FAILED == tmp
    #   $stderr.puts "(**) {#{__method__}} seq. send_at(): failed (#{tmp})."
    # else
    #   $stderr.puts "(**) {#{__method__}} seq. send_at(): succeeded (#{tmp})."
    # end
    # FFS.event_delete(ev)
  }

end


# schedule the arpeggio's notes.
#
#
def schedule_pattern
  #
  note_time     = @time_marker
  note_duration = @duration/@pattern_size

  #
  (0...@pattern_size).each do |_i|
    schedule_noteon(0, @notes[_i], note_time)
    note_time += note_duration
    schedule_noteoff(0, @notes[_i], note_time)
  end

  @time_marker += @duration
end

#
@seq_cb_ptr = FFS.define_event_callback{|time, ev, seq, data|
  #
  schedule_timer_event()
  schedule_pattern()
}

def usage( prog_name = __FILE__ )
  puts "Usage: #{prog_name} [soundfont] [steps [duration]]"
  puts "\t(optional) steps:    number of pattern notes, from 2" +
    " to #{@pattern_size}"
  puts "\t(optional) duration: of the pattern in ticks, default #{@duration}"
end


### main.

# n = nil
# if ARGV.size < 1
if ARGV[0] == '-h' || ARGV[0] == '--help'
  usage()
  exit 1
end

#
opt_idx = 0
fs = if File.exist?(ARGV[0].to_s)
       opt_idx += 1
       FiddleFluidSynth.new(soundfont_full_path: ARGV[0], player_f: false)
     else
       FiddleFluidSynth.new(player_f: false)
     end

#
@seq   = fs.sequencer_new2
if @seq.null?
  raise "Cannot prepare the sequencer!"
end
puts "#seq. clients: #{@seq.count_clients}"

### register the synthesizer to the sequencer.
# @synth_dest  = fs.sequencer_register_fluidsynth(@seq, fs.synth)
@synth_dest  = @seq.register_fluidsynth(fs.synth)
if FFS::FLUID_FAILED == @synth_dest
  raise "Client (synth) registsteration failed."
end
puts "seq_id: #{@synth_dest}, #seq. clients:" +
  " #{@seq.count_clients}"

### register the sequencer client.
# @client_dest = fs.sequencer_register_client(
#                  @seq, name: 'ffs_metronome',
#                  event_callback: @seq_cb_ptr,
#                  data: nil)
@client_dest = @seq.register_client(
                 name: 'ffs_metronome',
                 event_callback: @seq_cb_ptr, data: nil)
if FFS::FLUID_FAILED == @client_dest
  raise "Client registsteration failed."
end
puts "seq_id: #{@client_dest}, #seq. clients:" +
  " #{@seq.count_clients}"

#
if ARGV.size >= 1 && ARGV[opt_idx]
  n = ARGV[opt_idx].to_i
  @pattern_size = n if n > 1 && (n < @pattern_size)
  opt_idx += 1
end

if ARGV.size >= 2 && ARGV[opt_idx]
  n = ARGV[opt_idx].to_i
  @duration = n if n > 0
  opt_idx += 1
end
$stderr.puts "@pattern_size: #{@pattern_size}, @duration: #{@duration}"


#
# @audiodriver = fs.audio_driver_prepare

# get the current time in ticks.
@time_marker = @seq.tick

# schedule patterns.
schedule_pattern()
schedule_timer_event()
schedule_pattern()


# wait for user input.
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
