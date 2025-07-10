#!/usr/bin/env ruby
#
#

# presets-each.rb  - list all presets of SoundFont files with
# bank and preset number.
# (SoundFont instance's `#each_preset` example)
#
# This code is in the public domain.
#
# [YAMAMOTO, Masayuki]

require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


#
if ARGV[0].to_s == '-h' || ARGV[0].to_s == '--help'
  puts "#{__FILE__} [soundfont fullpath]"
  exit 0
end

#
fs = if ARGV[0].nil?
       FiddleFluidSynth.new
     else
       FiddleFluidSynth.new(soundfont_full_path: ARGV[0])
     end
fs.start

#
puts "sfid_ary: #{fs.sfid_ary}"

#
sfcount = fs.sfonts.size
fs.sfonts.each_with_index do |sfont, _i|

  #
  sfid  = sfont.sfid
  name  = sfont.name

  #
  puts "#{_i+1}/#{sfcount}. sfont: #{name}, sfid: #{sfid}" +
    " (sfont instance addr: 0x#{sfont.to_i.to_s(16)}:#{sfont.class})"

  #
  sfont.each_preset do |_preset|
    name    = _preset.name
    prenum  = _preset.num
    bknum   = _preset.bknum

    #
    puts "  %05d:%03d" % [bknum,prenum] +
      ", name: #{name}" +
      " (preset obj addr: 0x#{_preset.to_i.to_s(16)})"
  end

end


#
fs.raise_error_in_callback
fs.delete


####
