#
# filename: fiddle-fluidstynth/logging/logging.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Logging interface.
  # ==== References
  # - API References, [Logging](https://www.fluidsynth.org/api/group__logging.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Enumerations
  #
  #

  ### FluidSynth log levels.
  enum(
    :fluid_log_level,
    FLUID_PANIC:    nil,   # The synth can't function correctly any more.
    FLUID_ERR:      nil,   # Serious error occurred.
    FLUID_WARN:     nil,   # Warning.
    FLUID_INFO:     nil,   # Verbose informational messages.
    FLUID_DBG:      nil,   # Debugging messages.
    LAST_LOG_LEVEL: nil)

  #
  module C

    # Typedefs
    #
    #

    # Log function handler callback type used by fluid_set_log_function().
    typealias 'fluid_log_function_t', 'void*'

    # Functions.
    #
    #

    # Default log function which prints to the stderr.
    extern 'void fluid_default_log_function(int, char*, void*)'

    # Print a message to the log.
    extern 'int fluid_log(int, char*, ...)'

    # Installs a new log function for a specified log level.
    extern 'fluid_log_function_t fluid_set_log_function' +
      '(int, fluid_log_function_t, void*)'

  end
end


#
#
#
class FiddleFluidSynth

  def self.default_log_function( level: , message: , data: )
    ret = C.fluid_default_log_function(level, message, data)
    ret
  end

  def self.log( level: , fmt: , **args )
    ret = C.fluid_log(level, fmt, args)
    ret
  end

  def self.set_log_function( level: , func: , data: )
    ret = C.fluid_set_log_function(level, func, data)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/logging/logging.rb
