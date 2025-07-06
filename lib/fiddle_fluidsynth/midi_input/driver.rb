#
# filename: fiddle-fluidstynth/midi_input/driver.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for managing MIDI drivers.
  # ==== References
  # - MIDI Input/[MIDI Driver](https://www.fluidsynth.org/api/group__midi__driver.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C


    # Lifecycle Functions.
    #
    #

    # Create a new MIDI driver instance.
    # [MIDI driver settings](https://www.fluidsynth.org/api/settings_midi.html)
    # [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html)
    #
    extern 'fluid_midi_driver_t* new_fluid_midi_driver' +
      '(fluid_settings_t*, handle_midi_event_func_t*, void*)'

    # Delete a MIDI driver instance.
    extern 'void delete_fluid_midi_driver(fluid_midi_driver_t*)'    #


    # Functions.
    #
    #


  end
end


#
#
#
class FiddleFluidSynth

  #
  #
  # ==== See Also
  # - util/callback.rb
  #
  def self.midi_driver_new( settings: ,
                            handler: Midi_event_func_default, handler_data: nil )
    ret = C.new_fluid_midi_driver(settings, handler, handler_data)
    ret
  end
  def midi_driver_new( settings = self.settings,
                       handler: Midi_event_func_default, handler_data: nil )
    self.class.midi_driver_new(
      settings: settings, handler: handler, handler_data: handler_data)
  end

  def self.midi_driver_delete( driver )
    ret = C.delete_fluid_midi_driver(driver)
    ret
  end
  def midi_driver_delete( driver )
    self.class.midi_driver_delete(driver)
  end

end


#### endof filename: fiddle-fluidstynth/midi_input/driver.rb
