#!/usr/bin/env ruby
#
#
#

# `ffs_test3.rb` is the fiddle_fluidsynth version of `test3.rb` in
# ruby-fluidsynth.gem.
#
# This is from `ruby-fluidsynth.gem` by Daniel W.Steinbrook (2011).
# (https://github.com/steinbro/ruby-fluidsynth)
#

#
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


#
fs = FiddleFluidSynth.new(soundfont_name: nil)
fs.start

sfid = fs.synth_sfload(filename: "#{__dir__}/example.sf2", reset_presets: 0,
                       verbose_f: true)
sfont = fs.synth_get_sfont_by_id(id: sfid)
sfont_name = fs.sfont_get_name(sfont)

puts "sfont_name: #{sfont_name}"

fs.program_select(ch: 0, sfid: sfid, bknum: 0, prenum: 0)

fs.noteon(0, 60, 30)
sleep(0.3)

10.times do |i|
  fs.cc(0, 93, 127)
  fs.pitch_bend(0, i * 512)
  sleep(0.1)
end

fs.noteoff(0, 60)

sleep(1.0)


#
fs.raise_error_in_callback
fs.delete


#### end.
