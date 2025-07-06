#
# filename: soundfonts/soundfonts.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  #
  module C

    # SoundFont related functions.
    # ==== References
    # - API Reference, [SoundFonts](https://www.fluidsynth.org/api/group__soundfonts.html)
    # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
    #


    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Pins all samples of the given preset.
    extern 'int fluid_synth_pin_preset(fluid_synth_t*, int, int, int)'

    # Unpin all samples of the given preset.
    extern 'int fluid_synth_unpin_preset(fluid_synth_t*, int, int, int)'


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
  def synth_pin_preset( synth=self.synth, sfid: , bknum: , prenum: )
    ret = C.fluid_synth_pin_preset(synth, sfid, bknum, prenum)
    ret
  end
  def synth_unpin_preset( synth=self.synth, sfid: , bknum: , prenum: )
    ret = C.fluid_synth_unpin_preset(synth, sfid, bknum, prenum)
    ret
  end

end


#### endof filename: soundfonts/soundfonts.rb
