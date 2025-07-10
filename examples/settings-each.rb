#!/usr/bin/env ruby
#
#

# List all settings (settings' iterator test program).
#
# References:
# - Libfluidsynth, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html)
#

#
require_relative '../lib/fiddle_fluidsynth'
#require 'fiddle_fluidsynth'


# fs = FiddleFluidSynth.new(soundfont_name: nil)
fs = if ARGV[0].nil?
       FiddleFluidSynth.new
     else
       FiddleFluidSynth.new(soundfont_full_path: ARGV[0])
     end

#
#
#
item_cnt = 0
fs.settings.each_setting{|data, name, type|
  item_cnt +=1

  #
  # $stderr.puts "{each_setting} data: #{data.null?}," +
  #   " name: #{name}, type: #{type}"
  puts "item (#{item_cnt}): \"#{name}\", type: #{type}"

  #
  mname = FiddleFluidSynth.settings_item_to_meth_name(name)
  mname_default = mname + "_default"
  mname_range   = mname + "_range"
  msg = ""
  if fs.settings.respond_to?(mname)
    msg += "  value: #{fs.settings.send(mname)}" +
      " (default: #{fs.settings.send(mname_default)}"
    msg += ", range: #{fs.settings.send(mname_range)}" unless \
      fs.settings.send(mname_range).nil?
    msg += ")"
  else
    puts "[BUG] item \"#{name}\" does NOT respond to ##{mname}..."
  end
  puts "#{msg}"

  #
  puts "  notype?: #{fs.setting_type_is_notype?(type)}"
  puts "  num?:    #{fs.setting_type_is_num?(type)}"
  puts "  int?:    #{fs.setting_type_is_int?(type)}"
  puts "  str?:    #{fs.setting_type_is_str?(type)}"
  puts "  set?:    #{fs.setting_type_is_set?(type)}"

  #
  hints = fs.settings.hints_of(name)
  if hints.nil?
    puts "[ERROR] get_hints() is failed!"
  end
  puts "  hints: #{hints}"

  hint_bounded_above_f = fs.setting_hints_is_bounded_above?(hints)
  hint_bounded_below_f = fs.setting_hints_is_bounded_below?(hints)
  hint_optionlist_f    = fs.setting_hints_is_optionlist?(hints)
  hint_toggled_f       = fs.setting_hints_is_toggled?(hints)

  puts "    bounded above?: #{hint_bounded_above_f}"
  puts "    bounded below?: #{hint_bounded_below_f}"
  puts "    optionlist?:    #{hint_optionlist_f}"
  puts "    toggled?:       #{hint_toggled_f}"

  #
  if fs.setting_type_is_str?(type) && 
      fs.setting_hints_is_optionlist?(hints)
      # fs.settings.hints_is_optionlist?(name)

    tmp_opts = []
    fs.settings.each_option_of(name){|data,name,option|
      tmp_opts << option
    }
    puts "    #{name} is string and optionlist:"
    puts "    opt. (#{tmp_opts.size}):"
    tmp_opts.each_with_index do |anopt, _i|
      puts "      (#{_i+1}) \"#{anopt}\""
    end
  else
    # puts "    #{name} is NOT string and optionlist:"
  end

  # test.
  # raise SyntaxError, "test."
  #
}
puts


#
fs.raise_error_in_callback
fs.delete
puts "end."


####
