#
# filename: fiddle-fluidstynth/command_interface/server.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # TCP socket server for a command handler.
  # ==== References
  # - API References, Command Interface/[Command Server](https://www.fluidsynth.org/api/group__command__server.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Lifecycle Functions.
    #
    #

    # Create a new TCP/IP command shell server.
    extern 'fluid_server_t* new_fluid_server' +
      '(fluid_settings_t*, fluid_synth_t*, fluid_midi_router_t*)'

    # Create a new TCP/IP command shell server.
    extern 'fluid_server_t* new_fluid_server2' +
      '(fluid_settings_t*, fluid_synth_t*,' +
      ' fluid_midi_router_t*, fluid_player_t*)'

    # Delete a TCP/IP shell server.
    extern 'void delete_fluid_server(fluid_server_t*)'

    # Join a shell server thread (wait until it quits).
    extern 'int fluid_server_join(fluid_server_t*)'


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

  def server_new( settings: , synth: , router: )
    ret = C.new_fluid_server(synth, router)
    ret
  end

  def server_new2( settings: , synth: , router: , player: )
    ret = C.new_fluid_server2(settings, synth, router, player)
    ret
  end

  def server_delete( server )
    ret = C.delete_fluid_server(server)
    ret
  end

  def server_join( server )
    ret = C.fluid_server_join(server)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/command_interface/server.rb
