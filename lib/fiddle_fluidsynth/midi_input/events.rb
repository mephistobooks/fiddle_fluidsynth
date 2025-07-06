#
# filename: fiddle-fluidstynth/midi_input/events.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions to create, modify, query and delete MIDI events.
  # ==== References
  # - API Reference, MIDI Input/[MIDI Events](https://www.fluidsynth.org/api/group__midi__events.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  # ==== See Also
  # - sequencer/events.rb

  #
  module C

    # Lifecycle Functions.
    #
    #

    # Create a MIDI event structure.
    extern 'fluid_midi_event_t* new_fluid_midi_event(void)'

    # Delete MIDI event structure.
    extern 'void delete_fluid_midi_event(fluid_midi_event_t*)'


    # Functions.
    #
    #

    # Get the channel field of a MIDI event structure.
    extern 'int fluid_midi_event_get_channel(fluid_midi_event_t*)'

    # Get the control number of a MIDI event structure.
    extern 'int fluid_midi_event_get_control(fluid_midi_event_t*)'

    # Get the key field of a MIDI event structure.
    extern 'int fluid_midi_event_get_key(fluid_midi_event_t*)'

    # Get the lyric of a MIDI event structure.
    #  FIXME. void**
    # extern 'int fluid_midi_event_get_lyrics(void*, void**, void*)'
    extern 'int fluid_midi_event_get_lyrics(fluid_midi_event_t*, void*, void*)'

    # Get the pitch field of a MIDI event structure.
    extern 'int fluid_midi_event_get_pitch(fluid_midi_event_t*)'

    #  Get the program field of a MIDI event structure.
    extern 'int fluid_midi_event_get_program(fluid_midi_event_t*)'

    # Get the text of a MIDI event structure.
    #  FIXME. void**
    # extern 'int fluid_midi_event_get_text(void*, void**, void*)'
    extern 'int fluid_midi_event_get_text(fluid_midi_event_t*, void*, void*)'

    # Get the event type field of a MIDI event structure.
    extern 'int fluid_midi_event_get_type(fluid_midi_event_t*)'

    # Get the value field from a MIDI event structure.
    extern 'int fluid_midi_event_get_value(fluid_midi_event_t*)'

    # Get the velocity field of a MIDI event structure.
    extern 'int fluid_midi_event_get_velocity(fluid_midi_event_t*)'

    ###

    # Set the channel field of a MIDI event structure.
    extern 'int fluid_midi_event_set_channel(fluid_midi_event_t*, int)'

    # Set the control field of a MIDI event structure.
    extern 'int fluid_midi_event_set_control(fluid_midi_event_t*, int)'

    # Set the key field of a MIDI event structure.
    extern 'int fluid_midi_event_set_key(fluid_midi_event_t*, int)'

    # Assign lyric data to a MIDI event structure.
    extern 'int fluid_midi_event_set_lyrics' +
      '(fluid_midi_event_t*, void*, int, int)'

    # Set the pitch field of a MIDI event structure.
    extern 'int fluid_midi_event_set_pitch(fluid_midi_event_t*, int)'

    # Set the program field of a MIDI event structure.
    extern 'int fluid_midi_event_set_program(fluid_midi_event_t*, int)'

    # Assign sysex data to a MIDI event structure.
    extern 'int fluid_midi_event_set_sysex(fluid_midi_event_t*, void*, int, int)'

    # Assign text data to a MIDI event structure.
    extern 'int fluid_midi_event_set_text(fluid_midi_event_t*, void*, int, int)'

    #  Set the event type field of a MIDI event structure.
    extern 'int fluid_midi_event_set_type(fluid_midi_event_t*, int)'

    #  Set the value field of a MIDI event structure.
    extern 'int fluid_midi_event_set_value(fluid_midi_event_t*, int)'

    #  Set the velocity field of a MIDI event structure.
    extern 'int fluid_midi_event_set_velocity(fluid_midi_event_t*, int)'


  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  def self.midi_event_new()
    ret = C.new_fluid_midi_event()
    ret
  end
  def midi_event_new()
    self.class.midi_event_new()
  end

  def self.midi_event_delete( ev )
    ret = C.delete_fluid_midi_event(ev)
    ret
  end
  def midi_event_delete( ev )
    self.class.midi_event_delete(ev)
  end

end


# Functions.
#
#

### getter-related midi event.
class FiddleFluidSynth

  def midi_event_get_channel( ev )
    ret = C.fluid_midi_event_get_channel(ev)
    ret
  end

  def midi_event_get_control( ev )
    ret = C.fluid_midi_event_get_control(ev)
    ret
  end

  def midi_event_get_key( ev )
    ret = C.fluid_midi_event_get_key(ev)
    ret
  end

  def midi_event_get_lyrics( ev, data, size )
    ret = C.fluid_midi_event_get_lyrics(ev, data, size)
    ret
  end

  def midi_event_get_pitch( ev )
    ret = C.fluid_midi_event_get_pitch(ev)
    ret
  end

  def midi_event_get_program( ev )
    ret = C.fluid_midi_event_get_program(ev)
    ret
  end

  def midi_event_get_text( ev, data: , size: )
    ret = C.fluid_midi_event_get_text(ev, data, size)
    ret
  end

  def midi_event_get_type( ev )
    ret = C.fluid_midi_event_get_type(ev)
    ret
  end

  def midi_event_get_value( ev )
    ret = C.fluid_midi_event_get_value(ev)
    ret
  end

  def midi_event_get_velocity( ev )
    ret = C.fluid_midi_event_get_velocity(ev)
    ret
  end

end

### setter-related midi events.
class FiddleFluidSynth

  def midi_event_set_channel( ev, ch: )
    ret = C.fluid_midi_event_set_channel(ev, ch)
    ret
  end

  def midi_event_set_control( ev, ctrl: )
    ret = C.fluid_midi_event_set_control(ev, ctrl)
    ret
  end

  def midi_event_set_key( ev, key: )
    ret = C.fluid_midi_event_set_key(ev, key)
    ret
  end

  def midi_event_set_lyrics( ev, data: , size: , dynamic: )
    ret = C.fluid_midi_event_set_lyrics(ev, data, size, dynamic)
    ret
  end

  def midi_event_set_pitch( ev, val: )
    ret = C.fluid_midi_event_set_pitch(ev, val)
    ret
  end

  def midi_event_set_program( ev, val: )
    ret = C.fluid_midi_event_set_program(ev, val)
    ret
  end

  def midi_event_set_sysex( ev, data: , size: , dynamic: )
    ret = C.fluid_midi_event_set_sysex(ev, data, size, dynamic)
    ret
  end

  def midi_event_set_text( ev, data: , size: , dynamic: )
    ret = C.fluid_midi_event_set_text(ev, data, size, dynamic)
    ret
  end

  def midi_event_set_type( ev, type: )
    ret = C.fluid_midi_event_set_type(ev, type)
    ret
  end

  def midi_event_set_value( ev, val: )
    ret = C.fluid_midi_event_set_value(ev, val)
    ret
  end

  def midi_event_set_velocity( ev, val: )
    ret = C.fluid_midi_event_set_velocity(ev, val)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/midi_input/events.rb
