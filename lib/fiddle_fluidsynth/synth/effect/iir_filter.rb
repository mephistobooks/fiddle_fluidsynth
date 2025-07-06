#
# filename: fiddle-fluidstynth/synth/effect/iir_filter.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for configuring the built-in IIR filter effect.
  # ==== References
  # - API Reference, Synthesizer/[Effect - IIR Filter](https://www.fluidsynth.org/api/group__iir__filter.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Enumerations
  #
  #

  ### fluid_iir_filter_flags.
  # Specifies optional settings to use for the custom IIR filter.
  enum(
    :fluid_iir_filter_flags,
    FLUID_IIR_Q_LINEAR:      1 << 0,
    FLUID_IIR_Q_ZERO_OFF:    1 << 1,
    FLUID_IIR_Q_NO_GAIN_AMP: 1 << 2
  )

  ### fluid_iir_filter_type.
  # Specifies the type of filter to use for the custom IIR filter.
  enum(
    :fluid_iir_filter_type,
    FLUID_IIR_DISABLED:  0,
    FLUID_IIR_LOWPASS:   nil,
    FLUID_IIR_HIGHPASS:  nil,
    FLUID_IIR_LAST:      nil)

  #
  module C

    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Configure a general-purpose IIR biquad filter.
    extern 'int fluid_synth_set_custom_filter(fluid_synth_t*, int, int)'

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
  # ==== Args
  # type:: fluid_iir_filter_type.
  # flags:: fluid_iir_filter_flag.
  #
  def synth_set_custom_filter( synth=self.synth, type: , flags: )
    ret = C.fluid_synth_set_custom_filter(synth,type,flags)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/synth/effect/iir_filter.rb
