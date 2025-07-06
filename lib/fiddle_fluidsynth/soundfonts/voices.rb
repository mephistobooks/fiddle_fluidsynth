#
# filename: fiddle-fluidstynth/soundfonts/voices.rb
#


# References
# - fluidstynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Synthesis voice manipulation functions.
  # ==== References
  # - API Reference, SoundFonts/[Voice Manipulation](https://www.fluidsynth.org/api/group__voices.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)

  # Enumerations.
  #
  #

  # Enum used with fluid_voice_add_mod() to specify how to handle duplicate
  # modulators.
  enum(
    :fluid_voice_add_mod,
    FLUID_VOICE_OVERWRITE:  nil,
    FLUID_VOICE_ADD:        nil,
    FLUID_VOICE_DEFAULT:    nil,
  )

  #
  module C


    # Lifecycle Functions (MIDI Sequencer).
    #
    #


    # Functions.
    #
    #

    # Adds a modulator to the voice if the modulator has valid sources.
    extern 'void fluid_voice_add_mod(fluid_voice_t*, fluid_mod_t*, int)'

    # Get the value of a generator.
    extern 'float fluid_voice_gen_get(fluid_voice_t*, int)'

    # Offset the value of a generator.
    extern 'void fluid_voice_gen_incr(fluid_voice_t*, int, float)'

    # Set the value of a generator.
    extern 'void fluid_voice_gen_set(fluid_voice_t*, int, float)'

    # Return the effective MIDI key of the playing voice.
    extern 'int fluid_voice_get_actual_key(fluid_voice_t*)'

    # Return the effective MIDI velocity of the playing voice.
    extern 'int fluid_voice_get_actual_velocity(fluid_voice_t*)'

    # Return the MIDI channel the voice is playing on.
    extern 'int fluid_voice_get_channel(fluid_voice_t*)'

    #  Get the unique ID of the noteon-event.
    extern 'unsigned int fluid_voice_get_id(fluid_voice_t*)'

    # Return the MIDI key from the starting noteon event.
    extern 'int fluid_voice_get_key(fluid_voice_t*)'

    # Return the MIDI velocity from the starting noteon event.
    extern 'int fluid_voice_get_velocity(fluid_voice_t*)'

    # Check if a voice is ON.
    extern 'int fluid_voice_is_on(fluid_voice_t*)'

    # Check if a voice is producing sound.
    extern 'int fluid_voice_is_playing(fluid_voice_t*)'

    # Check if a voice keeps playing after it has received a noteoff due to
    # being held by sostenuto.
    extern 'int fluid_voice_is_sostenuto(fluid_voice_t*)'

    # Check if a voice keeps playing after it has received a noteoff due to
    # being held by sustain.
    extern 'int fluid_voice_is_sustained(fluid_voice_t*)'

    # Calculate the peak volume of a sample for voice off optimization.
    extern 'int fluid_voice_optimize_sample(fluid_sample_t*)'

    # Update all the synthesis parameters which depend on generator gen.
    extern 'void fluid_voice_update_param(fluid_voice_t*, int)'

  end
end


# Lifecycle Functions.
#
#


# Functions.
#
#
class FiddleFluidSynth

  def voice_add_mod( voice, mod: , mode: )
    ret = C.fluid_voice_add_mod(voice,mod,mode)
    ret
  end

  def voice_gen_get( voice, gen: )
    ret = C.fluid_voice_gen_get(voice,gen)
    ret
  end
  def voice_gen_incr( voice, i: , val: )
    ret = C.fluid_voice_gen_get(voice, i, val)
    ret
  end
  def voice_gen_set( voice, i: , val: )
    ret = C.fluid_voice_gen_get(voice,i,val)
    ret
  end

  def voice_get_actual_key( voice )
    ret = C.fluid_voice_get_actual_key(voice)
    ret
  end
  def voice_get_actual_velocity( voice )
    ret = C.fluid_voice_get_actual_velocity(voice)
    ret
  end
  def voice_get_channel( voice )
    ret = C.fluid_voice_get_channel(voice)
    ret
  end
  def voice_get_id( voice )
    ret = C.fluid_voice_get_id(voice)
    ret
  end
  def voice_get_key( voice )
    ret = C.fluid_voice_get_key(voice)
    ret
  end
  def voice_get_velocity( voice )
    ret = C.fluid_voice_get_velocity(voice)
    ret
  end

  #
  def voice_is_on( voice )
    ret = C.fluid_voice_is_on(voice)
    ret
  end
  def voice_is_playing( voice )
    ret = C.fluid_voice_is_playing(voice)
    ret
  end
  def voice_is_sostenuto( voice )
    ret = C.fluid_voice_is_sostenuto(voice)
    ret
  end
  def voice_is_sustained( voice )
    ret = C.fluid_voice_is_sustained(voice)
    ret
  end
  def voice_optimize_sample( voice )
    ret = C.fluid_voice_optimize_sample(voice)
    ret
  end
  def voice_update_param( voice, gen: )
    ret = C.fluid_voice_update_param(voice, gen)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/soundfonts/voices.rb
