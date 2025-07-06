#!/usr/bin/env ruby
#
#

# `ffs_test1.rb` is the fiddle_fluidsynth version of `test1.rb` in
# ruby-fluidsynth.gem.
#
# This is from `ruby-fluidsynth.gem` by Daniel W. Steinbrook (2011).
# (https://github.com/steinbro/ruby-fluidsynth)
#

require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


# fs = FiddleFluidSynth.new(soundfont_name: nil)
fs = FiddleFluidSynth.new
fs.start

sfid = fs.synth_sfload(filename: "#{__dir__}/example.sf2", reset_presets: 0,
                       verbose_f: true)
fs.program_select(ch: 0, sfid: sfid, bknum: 0, prenum: 0)

fs.noteon(0, 60, 30)
fs.noteon(0, 67, 30)
fs.noteon(0, 76, 30)

sleep(1.0)

fs.noteoff(0, 60)
fs.noteoff(0, 67)
fs.noteoff(0, 76)

sleep(1.0)


fs.raise_error_in_callback
fs.delete


#### end.
