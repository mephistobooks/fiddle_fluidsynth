#!/usr/bin/env ruby
#
#

# List all presets (full-scan version).
#
#

require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


# fs = FiddleFluidSynth.new(soundfont_name: nil)
#reset_presets = 1
reset_presets = 0
fs = if ARGV[0].nil?
       FiddleFluidSynth.new(reset_presets: reset_presets)
     else
       FiddleFluidSynth.new(
         soundfont_full_path: ARGV[0], reset_presets: reset_presets)
     end
fs.start

#
# sfont   = fs.sfont_new
puts "sfid_ary: #{fs.sfid_ary}"

#
fs.sfonts.each_with_index do |sfont, _i|
  name = fs.sfont_get_name(sfont)
  puts "#{_i+1}. sfont: #{name}" +
    " (sfont instance addr: 0x#{sfont.to_i.to_s(16)})"

  #
  for bknum in fs.bknum_range_whole
    for pgnum in fs.pgnum_range_whole
      _preset = fs.sfont_get_preset(sfont, bknum: bknum, prenum: pgnum)

      if !(_preset.null?)
        name   = fs.preset_get_name(_preset)
        prenum = fs.preset_get_num(_preset)
        bknum  = fs.preset_get_bknum(_preset)
        puts "  %05d:%03d %s" % [bknum,prenum,name] +
          " (preset obj addr: 0x#{_preset.to_i.to_s(16)})"
      end
    end
  end

end


#
fs.raise_error_in_callback
fs.delete
