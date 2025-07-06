#
# filename: fiddle-fluidstynth/midi_input/midi_input.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # MIDI Input Subsystem.
  # ==== References
  # - MIDI Input/[MIDI Driver](https://www.fluidsynth.org/api/group__midi__driver.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Typedefs.
    #
    #

    # Generic callback function for MIDI event handler.
    # typedef int(*handle_midi_event_func_t) (void *data, fluid_midi_event_t *event)
    typealias 'handle_midi_event_func_t', 'void*'

    # Generic callback function fired once by MIDI tick change.
    # typedef int(*handle_midi_tick_func_t) (void *data, int tick)
    typealias 'handle_midi_tick_func_t',  'void*'


    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Handle MIDI event from MIDI router, used as a callback function.
    extern 'int fluid_synth_handle_midi_event(void*, fluid_midi_event_t*)'

  end
end


#
#
#
class FiddleFluidSynth

  #
  # ==== See ALso
  # - midi_input/router.rb
  # - util/callback.rb:define_tick_callback().
  #
  def self.synth_handle_midi_event( data, event )
    ret = C.fluid_synth_handle_midi_event(data, event)
    ret
  end
  def synth_handle_midi_event( data, event )
    self.class.synth_handle_midi_event(data, event)
  end

end


#### endof filename: fiddle-fluidstynth/midi_input/midi_input.rb
