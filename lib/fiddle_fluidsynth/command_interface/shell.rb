#
# filename: fiddle-fluidstynth/command_interface/shell.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Interactive shell to control and configure a synthesizer instance.
  # ==== References
  # - API References, Command Interface/[Command Shell](https://www.fluidsynth.org/api/group__command__shell.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Lifecycle Functions.
    #
    #

    # Create a new FluidSynth command shell.
    extern 'fluid_shell_t* new_fluid_shell' +
      '(fluid_settings_t*, fluid_cmd_handler_t*,' +
      ' fluid_istream_t, fluid_ostream_t, int)'

    # A convenience function to create a shell interfacing to standard
    # input/output console streams.
    extern 'void fluid_usershell(fluid_settings_t*, fluid_cmd_handler_t*)'

    # Delete a FluidSynth command shell.
    extern 'void delete_fluid_shell(fluid_shell_t*)'

    # Functions.
    #
    #

    # nothing.


  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  # def cmd_shell_new( settings: , handler: , in: , out: , thread: )
  def cmd_shell_new( settings=self.settings,
                     handler: , instm: , outstm: , thread: )
    ret = C.new_fluid_shell(settings, handler, instm, outstm, thread)
    ret
  end

  def cmd_usershell( settings=self.settings, handler: )
    ret = C.fluid_usershell(settings, handler)
    ret
  end

  def cmd_shell_delete( shell )
    ret = C.delete_fluid_shell(shell)
    ret
  end

end

# Functions.
#
#


#### endof filename: fiddle-fluidstynth/command_interface/shell.rb
