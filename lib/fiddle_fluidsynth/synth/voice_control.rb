#
# filename: fiddle-fluidstynth/synth/voice_control.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Low-level access to synthesis voices.
  # ==== References
  # - API Reference, Synthesizer/[Voice Control](https://www.fluidsynth.org/api/group__voice__control.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Allocate a synthesis voice.
    extern 'fluid_voice_t* fluid_synth_alloc_voice' +
      '(fluid_synth_t*, fluid_sample_t*, int, int, int)'

    # Get list of currently playing voices.
    extern 'void fluid_synth_get_voicelist' +
      '(fluid_synth_t*, fluid_voice_t*, int, int)'

    # Create and start voices using an arbitrary preset and a MIDI note
    # on event.
    extern 'int fluid_synth_start' +
      '(fluid_synth_t*, unsigned int, fluid_preset_t*, int, int, int, int)'

    # Activate a voice previously allocated with fluid_synth_alloc_voice().
    extern 'void fluid_synth_start_voice(fluid_synth_t*, fluid_voice_t*)'

    # Stop notes for a given note event voice ID.
    extern 'int fluid_synth_stop(fluid_synth_t*, unsigned int)'


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
  def synth_alloc_voice( synth=self.synth, sample: , ch: , key: , vel: )
    ret = C.fluid_synth_alloc_voice(synth,sample,ch,key,vel)
    ret
  end

  def synth_get_voicelist( synth=self.synth, buf: , bufsize: , id: )
    ret = C.fluid_synth_get_voicelist(synth,buf,bufsize,id)
    ret
  end

  def synth_start( synth=self.synth,
                   id: , preset: , audio_ch: , ch: , key: , vel: )
    ret = C.fluid_synth_start(synth, id, preset, audio_ch, ch, key, vel)
    ret
  end

  def synth_start_voice( synth=self.synth, voice: )
    ret = C.fluid_synth_start_voice(synth, voice)
    ret
  end

  def synth_stop( synth=self.synth, voice_id: )
    ret = C.fluid_synth_stop(synth, voice_id)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/synth/voice_control.rb
