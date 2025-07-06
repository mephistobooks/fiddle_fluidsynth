#
# filename: fiddle-fluidsynth/synth/params/params.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions to control and query synthesis parameters like gain and
  # polyphony count.
  # ==== References
  # - API Reference, Synthesizer/[Parameters](https://www.fluidsynth.org/api/group__synthesis__params.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #


  # Enumerations.
  #
  #

  FLUID_INTERP_4THORDER_EXT = 4
  FLUID_INTERP_7THORDER_EXT = 7
  enum(
    :fluid_interp,
    FLUID_INTERP_NONE:      0,
    FLUID_INTERP_LINEAR:    1,
    FLUID_INTERP_4THORDER:  FLUID_INTERP_4THORDER_EXT,
    FLUID_INTERP_7THORDER:  FLUID_INTERP_7THORDER_EXT,
    FLUID_INTERP_DEFAULT:   FLUID_INTERP_4THORDER_EXT,
    FLUID_INTERP_HIGHEST:   FLUID_INTERP_7THORDER_EXT,
  )

  enum(
    :fluid_synth_add_mod,
    FLUID_SYNTH_OVERWRITE: nil,
    FLUID_SYNTH_ADD:       nil)

  #
  module C


    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Adds the specified modulator mod as default modulator to the synth.
    extern 'int fluid_synth_add_default_mod(fluid_synth_t*, fluid_mod_t*, int)'

    # Get the total count of audio channels.
    extern 'int fluid_synth_count_audio_channels(fluid_synth_t*)'

    # Get the total number of allocated audio channels.
    extern 'int fluid_synth_count_audio_groups(fluid_synth_t*)'

    # Get the total number of allocated effects channels.
    extern 'int fluid_synth_count_effects_channels(fluid_synth_t*)'

    # Get the total number of allocated effects units.
    extern 'int fluid_synth_count_effects_groups(fluid_synth_t*)'

    # Get the total count of MIDI channels.
    extern 'int fluid_synth_count_midi_channels(fluid_synth_t*)'

    # Get current number of active voices.
    extern 'int fluid_synth_get_active_voice_count(fluid_synth_t*)'

    # Get synth output gain value.
    extern 'float fluid_synth_get_gain(fluid_synth_t*)'

    # Get the internal synthesis buffer size value.
    extern 'int fluid_synth_get_internal_bufsize(fluid_synth_t*)'

    # Get current synthesizer polyphony (max number of voices).
    extern 'int fluid_synth_get_polyphony(fluid_synth_t*)'

    # Removes the specified modulator mod from the synth's default modulator
    # list.
    extern 'int fluid_synth_remove_default_mod(fluid_synth_t*, fluid_mod_t*)'

    # Set synth output gain value.
    extern 'void fluid_synth_set_gain(fluid_synth_t*, float)'

    # Set synthesis interpolation method on one or all MIDI channels.
    extern 'int fluid_synth_set_interp_method(fluid_synth_t*, int, int)'

    # Set synthesizer polyphony (max number of voices).
    extern 'int fluid_synth_set_polyphony(fluid_synth_t*, int)'

    # Set up an event to change the sample-rate of the synth during the next
    # rendering call.
    extern 'void fluid_synth_set_sample_rate(fluid_synth_t*, float)'

  end
end


# Lifecycle Functions.
#
#


# Functions.
#
#
class FiddleFluidSynth

  #
  def synth_add_default_mod( synth=self.synth, mod: , mode: )
    ret = C.fluid_synth_add_default_mod(synth,mod,mode)
    ret
  end

  #
  def synth_count_audio_channels( synth=self.synth )
    ret = C.fluid_synth_count_audio_channels(synth)
    ret
  end

  def synth_count_audio_groups( synth=self.synth )
    ret = C.fluid_synth_count_audio_groups(synth)
    ret
  end

  def synth_count_effects_channels( synth=self.synth )
    ret = C.fluid_synth_count_effects_channels(synth)
    ret
  end

  def synth_count_effects_groups( synth=self.synth )
    ret = C.fluid_synth_count_effects_groups(synth)
    ret
  end

  def synth_count_midi_channels( synth=self.synth )
    ret = C.fluid_synth_count_midi_channels(synth)
    ret
  end

  #
  def synth_get_active_voice_count( synth=self.synth )
    ret = C.fluid_synth_get_active_voice_count(synth)
    ret
  end

  def synth_get_gain( synth=self.synth )
    ret = C.fluid_synth_get_gain(synth)
    ret
  end

  def synth_get_internal_bufsize( synth=self.synth )
    ret = C.fluid_synth_get_internal_bufsize(synth)
    ret
  end

  def synth_get_polyphony( synth=self.synth )
    ret = C.fluid_synth_get_polyphony(synth)
    ret
  end

  #
  def synth_remove_default_mod( synth=self.synth, mod: )
    ret = C.fluid_synth_remove_default_mod(synth, mod)
    ret
  end

  def synth_set_gain( synth=self.synth, gain: )
    ret = C.fluid_synth_set_gain(synth, gain)
    ret
  end

  def synth_set_interp_method( synth=self.synth, ch: , interp_method: )
    ret = C.fluid_synth_set_interp_method(synth, ch, interp_method)
    ret
  end

  def synth_set_polyphony( synth=self.synth, polyphony: )
    ret = C.fluid_synth_set_polyphony(synth, polyphony)
    ret
  end

  #
  # - [fluid_synth_set_sample_rate()](https://www.fluidsynth.org/api/group__synthesis__params.html#ga58a436738d2a21b160b0732024bb4dbe)
  #
  def synth_set_sample_rate( synth=self.synth, sample_rate: )
    deprecated_msg(__method__)
    ret = C.fluid_synth_set_sample_rate(synth, sample_rate)
    ret
  end

end


#### endof filename: fiddle-fluidsynth/synth/params/params.rb
