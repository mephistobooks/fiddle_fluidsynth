#!/usr/bin/env ruby
#
#
#

# ffs_midiplay.rb  - fiddle_fluidsynth MIDI file player (tick callback
# example).
# This code is in the public domain.
#
# [YAMAMOTO, Masayuki]
#

#
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


#
DEFAULT_SF2_NAME = "default.sf2"
f_1 = ARGV[0]
f_2 = ARGV[1]

f_midi = f_2 || f_1
f_sf2  = (f_2.nil?)? DEFAULT_SF2_NAME : f_1
puts "SoundFont: #{f_sf2}, MIDI file #{f_midi}"

if f_midi.nil?
  $stderr.puts "Help: #{File.basename(__FILE__)} [SoundFont] MIDI-file"
  raise "Specify a MIDI file you want to play at least."
end

#
#
#
fs = if File.exist?(f_sf2)
       FiddleFluidSynth.new(soundfont_full_path: f_sf2)
     else
       FiddleFluidSynth.new(soundfont_name: f_sf2)
     end
fs.start

#
#
#
is_midi = fs.is_midifile(f_midi)
raise "MIDI file is strange (#{is_midi}): #{f_midi}" \
  unless fs.is_midifile?(f_midi)

ver_s   = fs.fluidsynth_version_str
ver_ary = fs.fluidsynth_version

puts "MIDI file (#{is_midi}): #{f_midi}"
puts "fluidsynth version_str: #{ver_s} (by version: #{ver_ary})"
puts

#
#
#
fs.player_file(f_midi)
time_start = Time.now
puts "#{time_start}: Playing #{f_midi}"


#
# we can pass user_data via handler_data as follows, but this is completely
# meaningless in FiddleFluidSynth.
#
# because we use the closure to define the callback function, i.e.,
# we can use any variables in the callback freely.
#
# ```
# str_ptr = FFI::MemoryPointer.from_string("this is a test.")
# fdl_ptr = Fiddle::Pointer.new(str_ptr.address)
#
# fs.player_set_tick_callback(handler_data: fdl_ptr_ary){|user_data, cur_tick|
#    :
#    puts "#{user_data}/#{user_data.read_string}"  # user_data is FFI::Pointer.
#    :
# }
# ```
#
fs.player_set_tick_callback{|user_data, cur_tick|
  #
  total_ticks = fs.player_get_total_ticks

  #
  status = fs.player_status
  bpm    = fs.player_bpm

  #
  # puts "#{user_data}/#{user_data.address}"
  # puts "#{user_data}/#{user_data.read_string}"
  puts "#{Time.now}: player status: #{status}/bpm: #{bpm}"

  #
  if cur_tick <= total_ticks
    puts "Tick: %4d / %4d" % [cur_tick, total_ticks]
  else
    puts "(**) All events in the MIDI file are executed" +
      " (Tick: %4d / %4d)" % [cur_tick, total_ticks]
  end
}


#
#
#
until fs.player_is_done?
  sleep(1.0)
end


#
#
#
fs.raise_error_in_callback
fs.delete
time_end = Time.now
puts "#{time_end}: Finished (in #{time_end-time_start} [sec])."


#### end.
