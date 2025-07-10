#
# filename: fiddle-fluidsynth/audio_output/driver.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  #
  module C

    # Functions for managing audio drivers and file renderers.
    # ==== References
    # - Audio Output/[Audio Driver](https://www.fluidsynth.org/api/group__audio__driver.html)
    # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
    #

    ### basic types are in types/types.rb

    # Callback function type used with new_fluid_audio_driver2() to allow
    # for custom user audio processing before the audio is sent to the driver.
    typealias 'fluid_audio_func_t', 'void'


    # Lifecycle Functions.
    #
    #
    extern 'fluid_audio_driver_t* new_fluid_audio_driver' +
      '(fluid_settings_t*, fluid_synth_t*)'
    extern 'fluid_audio_driver_t* new_fluid_audio_driver2' +
      '(fluid_settings_t*, fluid_audio_func_t*, void*)'
    extern 'void delete_fluid_audio_driver(fluid_audio_driver_t*)'    #


    # Functions.
    #
    #
    extern 'int fluid_audio_driver_register(char**)'    #

  end
end


#
#
#
class FiddleFluidSynth

  # Create a new audio driver.
  #
  def self.audio_driver_new( synth: , settings: )
    ret = C.new_fluid_audio_driver(settings, synth)
    # ret.extend(Interface::AudioOutputDriver)
    #
    ret
  end
  def audio_driver_new( synth: self.synth, settings: self.settings )
    self.class.audio_driver_new(synth: synth, settings: settings)
  end


  # Create a new audio driver.
  # ==== Args
  #
  def self.audio_driver_new2( settings: , audio_func: , data: nil )
    ret = C.new_fluid_audio_driver2(settings, audio_func, data)
    # ret.extend(Interface::AudioOutputDriver)
    #
    ret
  end
  def audio_driver_new2( audio_func: , data: nil, settings: self.settings )
    self.class.audio_driver_new2(
      audio_func: audio_func, data: data, settings: settings)
  end


  # Deletes an audio driver instance.
  def self.audio_driver_delete( driver )
    ret = C.delete_fluid_audio_driver(driver)
    ret
  end
  def audio_driver_delete( driver = self.audio_driver )
    self.class.audio_driver_delete(driver)
  end

end

#
#
#
class FiddleFluidSynth

  # Registers audio drivers to use.
  def audio_driver_register( adrivers = nil )
    ret = C.fluid_audio_driver_register(adrivers)
    ret
  end

end


#### endof filename: fiddle-fluidsynth/audio_output/driver.rb
