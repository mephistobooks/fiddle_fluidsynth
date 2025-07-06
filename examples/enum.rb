#!/usr/bin/env ruby
#
#
#

# List all enumerations defined for fiddle_fluidsynth.
#
#
require_relative '../lib/fiddle_fluidsynth'
# require 'fiddle_fluidsynth'


#
FiddleFluidSynth.constants.grep(/^Enum/).sort.each_with_index do |_enum, _i|

  puts "#{_i+1}. #{_enum}:"
  puts FiddleFluidSynth.const_get(_enum).constants.map{|e|
    v = FiddleFluidSynth.const_get(_enum).const_get(e)

    [e, v]
  }.sort_by{|e| e.last}.map.with_index{|e,_i|
    "(#{_i+1}) FiddleFluidSynth::#{_enum}::#{e.first} = #{e.last}" +
      " = FiddleFluidSynth::#{e.first} (#{FiddleFluidSynth.const_get(e.first)})"
  }
  puts

end




#### end.
