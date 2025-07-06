#!/usr/bin/env ruby
#
#
#

# Original comments:
# FluidSynth Simple - An example of using fluidsynth
#
# This code is in the public domain.
#
# To compile:
#   gcc -g -O -o fluidsynth_simple fluidsynth_simple.c -lfluidsynth
#
# To run
#   fluidsynth_simple soundfont
#
# [Peter Hanappe]
#
#


# `ffs_simple.rb` is the fiddle_fluidsynth version of `fluidsynth_simple.c`
# This code is in the public domain.
#
# [YAMAMOTO, Masayuki]

#
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'

#
fs = FiddleFluidSynth.new(player_f: false)

#
fs.noteon(0, 60, 100)
print 'Press "Enter" to stop: '
$stdin.getc
puts "done."


fs.raise_error_in_callback
fs.delete


#### end.
