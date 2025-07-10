#! /usr/bin/env ruby
#
#

# Fiddle::Pointer read/write example.
#
#
require_relative "#{__dir__}/../lib/fiddle-fluidsynth"
#require "fiddle_fluidsynth"


dbl_p = Fiddle::Pointer.malloc_dbl
Fiddle::Pointer.set_dbl(dbl_p, 4.6692)
fbc = Fiddle::Pointer.decode1_dbl(dbl_p)
puts "decoded: #{fbc}"


####
