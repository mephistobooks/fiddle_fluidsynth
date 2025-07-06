#
# filename: fiddle-fluidstynth/command_interface/handler.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Handles text commands and reading of configuration files.
  # ==== References
  # - API References, Command Interface/[Command Handler](https://www.fluidsynth.org/api/group__command__handler.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Lifecycle Functions.
    #
    #

    # Create a new command handler.
    extern 'fluid_cmd_handler_t* new_fluid_cmd_handler' +
      '(fluid_synth_t*, fluid_midi_router_t*)'

    # Create a new command handler.
    extern 'fluid_cmd_handler_t* new_fluid_cmd_handler2' +
      '(fluid_settings_t*, fluid_synth_t*,' +
      ' fluid_midi_router_t*, fluid_player_t*)'

    # Delete a command handler.
    extern 'void delete_fluid_cmd_handler(fluid_cmd_handler_t*)'


    # Functions.
    #
    #

    # Process a string command.
    # extern 'int fluid_command(void*, void*, int)'
    extern 'int fluid_command(fluid_cmd_handler_t*, char*, fluid_ostream_t)'

    # Execute shell commands in a file.
    extern 'int fluid_source(fluid_cmd_handler_t*, char*)'


  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  def cmd_handler_new( synth=self.synth, router: )
    ret = C.new_fluid_cmd_handler(synth, router)
    ret
  end

  def cmd_handler_new2( settings=self.settings,
                        synth: , router: , player: )
    ret = C.new_fluid_cmd_handler2(settings, synth, router, player)
    ret
  end

  def cmd_handler_delete( cmd_handler )
    ret = C.delete_fluid_cmd_handler(cmd_handler)
    ret
  end

end


# Functions.
#
#
class FiddleFluidSynth

  def cmd_command( handler, cmd, out )
    ret = C.fluid_command(handler, cmd, out)
    ret
  end

  def cmd_source( handler, filename )
    ret = C.fluid_source(handler, filename)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/command_interface/handler.rb
