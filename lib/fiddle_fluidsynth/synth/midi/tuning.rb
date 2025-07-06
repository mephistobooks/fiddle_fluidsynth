#
# filename: fiddle-fluidstynth/synth/midi/tuning.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # The functions in this section implement the MIDI Tuning Standard
  # interface.
  # ==== References
  # - API Reference, Synthesizer/[MIDI Tuning](https://www.fluidsynth.org/api/group__tuning.html)
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

    # Set the tuning of the entire MIDI note scale.
    extern 'int fluid_synth_activate_key_tuning' +
      '(fluid_synth_t*, int, int, char*, double*, int)'

    # Activate an octave tuning on every octave in the MIDI note scale.
    extern 'int fluid_synth_activate_octave_tuning' +
      '(fluid_synth_t*, int, int, char*, double*, int)'

    # Activate a tuning scale on a MIDI channel.
    extern 'int fluid_synth_activate_tuning(fluid_synth_t*, int, int, int, int)'

    # Clear tuning scale on a MIDI channel (use default equal tempered scale).
    extern 'int fluid_synth_deactivate_tuning(fluid_synth_t*, int, int)'

    # Set tuning values for one or more MIDI notes for an existing tuning.
    extern 'int fluid_synth_tune_notes' +
      '(fluid_synth_t*, int, int, int, int*, double*, int)'

    # Get the entire note tuning for a given MIDI bank and program.
    extern 'int fluid_synth_tuning_dump' +
      '(fluid_synth_t*, int, int, char*, int, double*)'

    # Advance to next tuning.
    extern 'int fluid_synth_tuning_iteration_next(fluid_synth_t*, int*, int*)'

    # Start tuning iteration.
    extern 'void fluid_synth_tuning_iteration_start(fluid_synth_t*)'


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
  def synth_activate_key_tuning( synth=self.synth,
                                 bknum: , pgnum: , name: , pitch: , apply: )
    ret = C.fluid_synth_activate_key_tuning(
            synth, bknum, pgnum, name, pitch, apply)
    ret
  end

  def synth_activate_octave_tuning( synth=self.synth,
                                    bknum: , pgnum: , name: , pitch: , apply: )
    ret = C.fluid_synth_activate_octave_tuning(
            synth, bknum, pgnum, name, pitch, apply)
    ret
  end

  def synth_activate_tuning( synth=self.synth, ch: , bknum: , pgnum: , apply: )
    ret = C.fluid_synth_activate_tuning(synth, ch, bknum, pgnum, apply)
    ret
  end

  #
  # ==== Args
  # apply:: TRUE to apply tuning change to active notes, FALSE otherwise
  #
  def synth_deactivate_tuning( synth=self.synth, ch: , apply: )
    ret = C.fluid_synth_deactivate_tuning(synth, ch, apply)
    ret
  end

  def synth_tune_notes( synth=self.synth,
                        bknum: , pgnum: , len: , key: , pitch: , apply: )
    ret = C.fluid_synth_tune_notes(synth, bknum, pgnum, len, key, pitch, apply)
    ret
  end

  def synth_tuning_dump( synth=self.synth,
                         bknum: , pgnum: , name: , len: , pitch: )
    ret = C.fluid_synth_tuning_dump(synth, bknum, pgnum, name, len, pitch)
    ret
  end

  def synth_tuning_iteration_next( synth=self.synth, bknum: ,  pgnum: )
    ret = C.fluid_synth_tuning_iteration_next(synth, bknum, pgnum)
    ret
  end

  def synth_tuning_iteration_start( synth=self.synth )
    ret = C.fluid_synth_tuning_iteration_start(synth)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/synth/midi/tuning.rb
