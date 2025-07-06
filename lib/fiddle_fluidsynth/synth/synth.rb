#
# filename: fiddle-fluidsynth/synth/synth.rb
#


# References
# - fluidstynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  #
  module C

    # SoundFont synthesizer.
    # ==== References
    # - API Reference, [Synthesizer](https://www.fluidsynth.org/api/group__synth.html)
    # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
    #

    # Lifecycle Functions.
    #
    #

    # Create new FluidSynth instance.
    extern 'fluid_synth_t* new_fluid_synth(fluid_settings_t*)'

    # Delete a FluidSynth instance.
    extern 'void delete_fluid_synth(fluid_synth_t*)'


    # Functions.
    #
    #

    # Get a textual representation of the last error.
    extern 'char* fluid_synth_error(fluid_synth_t*)'

    # Get the synth CPU load value.
    extern 'double fluid_synth_get_cpu_load(fluid_synth_t*)'

  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  #
  def self.synth_new( settings )
    ret = C.new_fluid_synth(settings)
    ret
  end
  def synth_new( settings=self.settings )
    # ret = C.new_fluid_synth(settings)
    self.class.synth_new(settings)
  end

  def self.synth_delete( synth )
    ret = C.delete_fluid_synth(synth)
    ret
  end
  def synth_delete( synth=self.synth )
    # ret = C.delete_fluid_synth(synth)
    # ret
    self.class.synth_delete(synth)
  end

end


# Functions.
#
#
class FiddleFluidSynth

  #
  def synth_error( synth=self.synth )
    deprecated_msg(__method__)
    ret = C.fluid_synth_error(synth)
    ret
  end

  #
  def synth_get_cpu_load( synth=self.synth )
    ret = C.fluid_synth_get_cpu_load(synth)
    ret
  end

  # in soundfonts/loader.rb:
  #
  #  def synth_add_sfloader( synth = self.synth, loader: )
  #    ret = C.fluid_synth_add_sfloader(synth, loader)
  #    ret
  #  end
  #
  #  def synth_get_channel_preset( synth = self.synth, ch: )
  #    ret = C.fluid_synth_get_channel_preset(synth, ch)
  #    ret
  #  end


  # in settings/settings.rb:
  #
  # def synth_get_settings( synth = self.synth )
  #   self.class.synth_get_settings(synth)
  # end


end


#### endof filename: fiddle-fluidsynth/synth/synth.rb
