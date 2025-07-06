#!/usr/bin/env ruby
#
#
#

# Original comments:
# An example of how to use FluidSynth.
#
# To compile it on Linux:
#  $ gcc -o example example.c `pkg-config fluidsynth --libs`
#
# To compile it on Windows:
#    ...
#
#
# Author: Peter Hanappe.
# This code is in the public domain. Use it as you like.
#

# `ffs_example.rb` is fiddle_fluidsynth version of `example.c`
# This code is also in the public domain.
#
# [YAMAMOTO, Masayuki]
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'

#
fs = FiddleFluidSynth.new(player_f: false)
srand(Process.pid)

#
12.times do |i|
    key = 60 + 12.0 * rand(0.0..1.0)
    # fs.noteon(0, key, 80)
    # fs.synth_noteon(ch: 0, key: key, vel: 80)
    fs.noteon(0, key, 80)
    sleep(1)
    # fs.noteoff(0, key)
    # fs.synth_noteoff(ch: 0, key: key)
    fs.noteoff(0, key)
end

fs.raise_error_in_callback
fs.delete


#### end.
