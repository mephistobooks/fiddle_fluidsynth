#
# filename: settings/settings.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for settings management.
  # ==== References
  # - API Reference, [Settings](https://www.fluidsynth.org/api/group__settings.html)
  # - [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #


  # Constants.
  #
  #

  # Hint FLUID_HINT_BOUNDED_ABOVE indicates that the UpperBound field of
  # the FLUID_PortRangeHint should be considered meaningful.
  FLUID_HINT_BOUNDED_ABOVE  = 0x2

  # Hint FLUID_HINT_BOUNDED_BELOW indicates that the LowerBound field of
  # the FLUID_PortRangeHint should be considered meaningful.
  FLUID_HINT_BOUNDED_BELOW  = 0x1

  # Setting is a list of string options.
  FLUID_HINT_OPTIONLIST     = 0x02

  # Hint FLUID_HINT_TOGGLED indicates that the data item should be 
  # considered a Boolean toggle.
  FLUID_HINT_TOGGLED        = 0x4


  # Enumerations.
  #
  #

  ### Settings type.
  enum(
    :fluid_types_enum,
    FLUID_NO_TYPE:     -1,
    FLUID_NUM_TYPE:   nil,
    FLUID_INT_TYPE:   nil,
    FLUID_STR_TYPE:   nil,
    FLUID_SET_TYPE:   nil,
  )

  #
  module C

    # Typedefs.
    #
    #

    # Callback function type used with fluid_settings_foreach_option()
    # ==== See Also
    # - util/util.rb: define_handler_ab()
    #
    #typedef void(*fluid_settings_foreach_option_t) (void *data, const char *name, const char *option)
    typealias 'fluid_settings_foreach_option_t', 'void*'

    # Callback function type used with fluid_settings_foreach()
    #typedef void(*fluid_settings_foreach_t) (void *data, const char *name, int type)
    typealias 'fluid_settings_foreach_t', 'void*'


    # Lifecycle Functions (MIDI Sequencer).
    #
    #

    # Create a new settings object.
    extern 'fluid_settings_t* new_fluid_settings(void)'

    # Delete the provided settings object.
    extern 'void delete_fluid_settings(fluid_settings_t*)'


    # Functions.
    #
    #

    # Copy the value of a string setting into the provided buffer (thread safe).
    extern 'int fluid_settings_copystr(fluid_settings_t*, char*, char*, int)'

    # Duplicate the value of a string setting.
    # FIXME. char**
    extern 'int fluid_settings_dupstr(fluid_settings_t*, char*, void*)'

    # Iterate the existing settings defined in a settings object, calling
    # the provided callback function for each setting.
    extern 'void fluid_settings_foreach' +
      '(fluid_settings_t*, void*, fluid_settings_foreach_t)'

    # Iterate the available options for a named string setting, calling
    # the provided callback function for each existing option.
    extern 'void fluid_settings_foreach_option' +
      '(fluid_settings_t*, char*, void*, fluid_settings_foreach_option_t)'

    # Get the hints for the named setting as an integer bitmap.
    extern 'int fluid_settings_get_hints(fluid_settings_t*, char*, int*)'

    # Get the type of the setting with the given name.
    extern 'int fluid_settings_get_type(fluid_settings_t*, char*)'

    # Get an integer value setting.
    extern 'int fluid_settings_getint(fluid_settings_t*, char*, int*)'

    # Get the default value of an integer setting.
    extern 'int fluid_settings_getint_default(fluid_settings_t*, char*, int*)'

    # Get the range of values of an integer setting.
    extern 'int fluid_settings_getint_range' +
      '(fluid_settings_t*, char*, int*, int*)'

    # Get the numeric value of a named setting.
    extern 'int fluid_settings_getnum(fluid_settings_t*, char*, double*)'

    # Get the default value of a named numeric (double) setting.
    extern 'int fluid_settings_getnum_default(fluid_settings_t*, char*, double*)'

    # Get the range of values of a numeric setting.
    extern 'int fluid_settings_getnum_range' +
      '(fluid_settings_t*, char*, double*, double*)'

    # Get the default value of a string setting.
    # char** =>use Fiddle::Pointer#ptr()
    extern 'int fluid_settings_getstr_default(fluid_settings_t*, char*, void*)'

    #  Ask whether the setting is changeable in real-time.
    extern 'int fluid_settings_is_realtime(fluid_settings_t*, char*)'

    #  Concatenate options for a string setting together with a separator
    #  between.
    extern 'void* fluid_settings_option_concat(fluid_settings_t*, char*, char*)'

    #  Count option string values for a string setting.
    extern 'int fluid_settings_option_count(fluid_settings_t*, char*)'

    #  Set an integer value for a setting.
    extern 'int fluid_settings_setint(fluid_settings_t*, char*, int)'

    #  Set a numeric value for a named setting.
    extern 'int fluid_settings_setnum(fluid_settings_t*, char*, double)'

    #  Set a string value for a named setting.
    extern 'int fluid_settings_setstr(fluid_settings_t*, char*, char*)'

    #  Test a string setting for some value.
    extern 'int fluid_settings_str_equal(fluid_settings_t*, char*, char*)'

    #  Get settings assigned to a synth.
    #
    extern 'void* fluid_synth_get_settings(fluid_synth_t*)'


  end
end


#
#
#
class FiddleFluidSynth

  module Interface;
    module Settings; end
  end

end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  #
  # ==== See Also
  # - `#synth_get_settings()`
  #
  def self.settings_new()
    ret = C.new_fluid_settings()

    if ret.nil? || ret.null?
      ret = nil
    else
      ret.extend(Interface::Settings)
    end
    ret
  end
  def settings_new()
    self.class.settings_new
  end

  def self.settings_delete( settings )
    ret = C.delete_fluid_settings(settings)
    ret
  end
  def settings_delete( settings )
    self.class.settings_delete(settings)
  end

end


# Functions.
#
#
class FiddleFluidSynth

  #
  def self.settings_copystr( settings, name: , str: , len: )
    ret = C.fluid_settings_copystr(settings, name, str, len)
    ret
  end
  def settings_copystr( settings = self.settings, name: , str: , len: )
    self.class.settings_copystr(settings, name: name, str: str, len: len)
  end

  #
  # ==== Args
  # out:: must be Fiddle::Pointer.malloc_voidp
  #
  def self.settings_dupstr( settings: , name: ,
                            out: Fiddle::Pointer.malloc_voidp )
    ret = nil
    tmp = C.fluid_settings_dupstr(settings, name, out)
    if FLUID_OK == tmp
      ret = out.ptr.to_s
    else
      raise "{#{__method__}} API call failed for name:" +
        " #{name}, out: #{out.inspect}."
    end
    ret
  end
  def settings_dupstr( name, settings = self.settings,
                       out: Fiddle::Pointer.malloc_voidp )
    self.class.settings_dupstr(
      settings: settings, name: name, out: out)
  end

  #
  def self.settings_foreach( settings, data: , func: )
    ret = C.fluid_settings_foreach(settings, data, func)
    ret
  end
  def settings_foreach( settings = self.settings, data: , func: )
    self.class.settings_foreach(settings, data: data, func: func)
  end

  def self.settings_foreach_option( settings, name: , data: , func: )
    ret = C.fluid_settings_foreach_option(settings, name, data, func)
    ret
  end
  class << self
    alias settings_option_foreach settings_foreach_option
  end
  def settings_foreach_option( settings = self.settings, name: , data: , func: )
    self.class.settings_foreach_option(
      settings, name: name, data: data, func: func)
  end
  alias settings_option_foreach settings_foreach_option

  #
  # ==== Args
  # outval:: pointer. Fiddle::Pointer.malloc_i
  #
  # ==== See Also
  # - `.#settings_get_type()`
  #
  # def settings_get_hints( settings: , name: , val: )
  # def settings_get_hints( name, outval: , settings: self.settings )
  # def self.settings_get_hints( settings, name: ,
  def self.settings_get_hints( name, settings: ,
                               outval: Fiddle::Pointer.malloc_i,
                               notify_f: true )
    ret = nil
    tmp = C.fluid_settings_get_hints(settings, name, outval)
    if FLUID_OK == tmp
      ret = Fiddle::Pointer.decode1_i(outval)
    else
      msg = "(**) Failed to get hints: #{name}. Maybe misspelled...?"
      if notify_f
        $stderr.puts "#{msg}"
      else
        raise "#{msg}"
      end
    end

    ret
  end
  def settings_get_hints( name, settings: self.settings,
                          outval: Fiddle::Pointer.malloc_i,
                          notify_f: true )
    self.class.settings_get_hints(
      name, settings: settings, outval: outval, notify_f: notify_f)
  end

  #
  # ==== See Also
  # - `.#settings_get_hints()`
  #
  # def self.settings_get_type( settings: , name: )
  def self.settings_get_type( name, settings: )
    ret = C.fluid_settings_get_type(settings, name)
    ret
  end
  # def settings_get_type( settings = self.settings, name: )
  def settings_get_type( name, settings: self.settings )
    self.class.settings_get_type(name, settings: settings)
  end

  #
  def self.settings_getint( settings, name: , val: )
    ret = C.fluid_settings_getint(settings, name, val)
    ret
  end
  def settings_getint( settings = self.settings, name: , val: )
    self.class.settings_getint(settings, name: name, val: val)
  end

  def self.settings_getint_default( settings, name: , val: )
    ret = C.fluid_settings_getint_default(settings, name, val)
    ret
  end
  def settings_getint_default( settings = self.settings, name: , val: )
    self.class.settings_getint_default(settings, name: name, val: val)
  end

  #
  def self.settings_getint_range( settings, name: , min: , max: )
    ret = C.fluid_settings_getint_range(settings, name, min, max)
    ret
  end
  def settings_getint_range( settings = self.settings, name: , min: , max: )
    self.class.settings_getint_range(settings, name: name, min: min, max: max)
  end

  #
  def self.settings_getnum( settings, name: , val: )
    ret = C.fluid_settings_getnum(settings, name, val)
    ret
  end
  def settings_getnum( settings = self.settings, name: , val: )
    self.class.settings_getnum(settings, name: name, val: val)
  end

  def self.settings_getnum_default( settings, name: , val: )
    ret = C.fluid_settings_getnum_default(settings, name, val)
    ret
  end
  def settings_getnum_default( settings = self.settings, name: , val: )
    self.class.settings_getnum_default(settings, name: name, val: val)
  end

  def self.settings_getnum_range( settings, name: , min: , max: )
    ret = C.fluid_settings_getnum_range(settings, name, min, max)
    ret
  end
  def settings_getnum_range( settings=self.settings, name: , min: , max: )
    self.class.settings_getnum_range(settings, name: name, min: min, max: max)
  end

  #
  def self.settings_getstr_default( settings, name: , defout: )
    ret = C.fluid_settings_getstr_default(settings, name, defout)
    ret
  end
  def settings_getstr_default( settings=self.settings, name: , defout: )
    self.class.settings_getstr_default(settings, name: name, defout: defout)
  end

  #
  def self.settings_is_realtime( settings, name: )
    ret = C.fluid_settings_is_realtime(settings, name)
    ret
  end
  def settings_is_realtime( settings=self.settings, name: )
    self.class.settings_is_realtime(settings, name: name)
  end

  #
  def self.settings_option_concat( settings, name: , separator: )
    ret = C.fluid_settings_option_concat(settings, name, separator)
    ret
  end
  def settings_option_concat( settings=self.settings, name: , separator: )
    self.class.settings_option_concat(settings, name: name, separator: separator)
  end

  def self.settings_option_count( settings, name: )
    ret = C.fluid_settings_option_count(settings, name)
    ret
  end
  def settings_option_count( settings=self.settings, name: )
    self.class.settings_option_count(settings, name: name)
  end

  ### setters.

  def self.settings_setint( settings, name: , val: )
    ret = C.fluid_settings_setint(settings, name, val)
    ret
  end
  def settings_setint( settings=self.settings, name: , val: )
    self.class.settings_setint(settings, name: name, val: val)
  end

  def self.settings_setnum( settings, name: , val: )
    ret = C.fluid_settings_setnum(settings, name, val)
    ret
  end
  def settings_setnum( settings=self.settings, name: , val: )
    self.class.settings_setnum(settings, name: name, val: val)
  end

  # def settings_setstr( settings: , name: , str: )
  def self.settings_setstr( settings, name: , val: )
    # ret = C.fluid_settings_setstr(settings, name, str)
    ret = C.fluid_settings_setstr(settings, name, val)
    ret
  end
  def settings_setstr( settings=self.settings, name: , val: )
    self.class.settings_setstr(settings, name: name, val: val)
  end

  #
  #def self.settings_str_equal( settings, name: , value: )
  def self.settings_str_equal( settings, name: , val: )
    ret = C.fluid_settings_str_equal(settings, name, val)
    ret
  end
  def settings_str_equal( settings=self.settings, name: , val: )
    self.class.settings_str_equal(settings, name: name, val: val)
  end

  ### synth...?

  #
  # ==== See Also
  # - `#settings_new()`
  #
  def self.synth_get_settings( synth )
    ret = C.fluid_synth_get_settings(synth)

    if ret.nil? || ret.null?
      ret = nil
    else
      ret.extend(FiddleFluidSynth::Interface::Settings)
    end
    ret
  end
  def synth_get_settings( synth = self.synth )
    self.class.synth_get_settings(synth)
  end

end


#### endof filename: settings/settings.rb
