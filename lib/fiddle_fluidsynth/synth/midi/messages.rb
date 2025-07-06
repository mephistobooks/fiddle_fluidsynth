#
# filename: synth/midi/messages.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # The MIDI channel message functions are mostly directly named after
  # their counterpart MIDI messages.
  # ==== References
  # - API Reference, Synthesizer/[MIDI Channel Messages](https://www.fluidsynth.org/api/group__midi__messages.html)
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

    # Turn off all voices that are playing on the given MIDI channel, by
    # putting them into release phase.
    extern 'int fluid_synth_all_notes_off(fluid_synth_t*, int)'

    # Immediately stop all voices on the given MIDI channel (skips release
    # phase).
    extern 'int fluid_synth_all_sounds_off(fluid_synth_t*, int)'

    # Set instrument bank number on a MIDI channel.
    extern 'int fluid_synth_bank_select(fluid_synth_t*, int, int)'

    # Send a MIDI controller event on a MIDI channel.
    extern 'int fluid_synth_cc(fluid_synth_t*, int, int, int)'

    # Set the MIDI channel pressure controller value.
    extern 'int fluid_synth_channel_pressure(fluid_synth_t*, int, int)'

    # Get current MIDI controller value on a MIDI channel.
    extern 'int fluid_synth_get_cc(fluid_synth_t*, int, int, int*)'

    # Retrieve the generator NRPN offset assigned to a MIDI channel.
    extern 'float fluid_synth_get_gen(fluid_synth_t*, int, int)'

    # Get the MIDI pitch bend controller value on a MIDI channel.
    extern 'int fluid_synth_get_pitch_bend(fluid_synth_t*, int, int*)'

    # Get MIDI pitch wheel sensitivity on a MIDI channel.
    extern 'int fluid_synth_get_pitch_wheel_sens(fluid_synth_t*, int, int*)'

    # Get current SoundFont ID, bank number and program number for a MIDI
    # channel.
    extern 'int fluid_synth_get_program' +
      '(fluid_synth_t*, int, int*, int*, int*)'

    # Set the MIDI polyphonic key pressure controller value.
    extern 'int fluid_synth_key_pressure(fluid_synth_t*, int, int, int)'

    # Sends a note-off event to a FluidSynth object.
    extern 'int fluid_synth_noteoff(fluid_synth_t*, int, int)'

    # Send a note-on event to a FluidSynth object.
    extern 'int fluid_synth_noteon(fluid_synth_t*, int, int, int)'

    # Set the MIDI pitch bend controller value on a MIDI channel.
    extern 'int fluid_synth_pitch_bend(fluid_synth_t*, int, int)'

    # Set MIDI pitch wheel sensitivity on a MIDI channel.
    extern 'int fluid_synth_pitch_wheel_sens(fluid_synth_t*, int, int)'

    # Send a program change event on a MIDI channel.
    extern 'int fluid_synth_program_change(fluid_synth_t*, int, int)'

    # Resend a bank select and a program change for every channel and assign
    # corresponding instruments.
    extern 'int fluid_synth_program_reset(fluid_synth_t*)'

    # Select an instrument on a MIDI channel by SoundFont ID, bank and 
    # program numbers.
    extern 'int fluid_synth_program_select(fluid_synth_t*, int, int, int, int)'

    # Select an instrument on a MIDI channel by SoundFont name, bank and
    # program numbers.
    extern 'int fluid_synth_program_select_by_sfont_name' +
      '(fluid_synth_t*, int, char*, int, int )'

    # Apply an offset to a SoundFont generator on a MIDI channel.
    extern 'int fluid_synth_set_gen(fluid_synth_t*, int, int, float)'

    # Set SoundFont ID on a MIDI channel.
    extern 'int fluid_synth_sfont_select(fluid_synth_t*, int, int)'

    # Process a MIDI SYSEX (system exclusive) message.
    extern 'int fluid_synth_sysex' +
      '(fluid_synth_t*, char*, int, char*, int*, int*, int)'

    # Send MIDI system reset command (big red 'panic' button), turns off
    # notes, resets controllers and restores initial basic channel
    # configuration.
    extern 'int fluid_synth_system_reset(fluid_synth_t*)'

    # Set the preset of a MIDI channel to an unassigned state.
    extern 'int fluid_synth_unset_program(fluid_synth_t*, int)'

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
  def synth_all_notes_off( synth=self.synth, ch: )
    ret = C.fluid_synth_all_notes_off(synth, ch)
    ret
  end
  def synth_all_sounds_off( synth=self.synth, ch: )
    ret = C.fluid_synth_all_sounds_off(synth, ch)
    ret
  end

  # def synth_bank_select( synth: , ch: , bank: )
  def synth_bank_select( synth=self.synth, ch: , bknum: )
    ret = C.fluid_synth_bank_select(synth, ch, bknum)
    ret
  end

  # def synth_cc( synth: , ch: , num: , val: )
  def synth_cc( synth=self.synth, ch: , num: , val: )
    ret = nil
    if (num < 0 || num > 127) || ch < 0 || (val < 0 || val > 127)
      ret = FLUID_FAILED
    else
      ret = C.fluid_synth_cc(synth, ch, num, val)
    end
    ret
  end

  #
  def synth_channel_pressure( synth=self.synth , ch: , val: )
    ret = C.fluid_synth_channel_pressure(synth, ch, val)
    ret
  end

  # getters.
  def synth_get_cc( synth=self.synth, ch: , num: , pval: )
    ret = C.fluid_synth_get_cc(synth, ch, num, pval)
    ret
  end

  def synth_get_gen( synth=self.synth, ch: , param: )
    ret = C.fluid_synth_get_gen(synth, ch, param)
    ret
  end

  def synth_get_pitch_bend( synth=self.synth, ch: , ppitch_bend: )
    ret = C.fluid_synth_get_pitch_bend(synth, ch, ppitch_bend)
    ret
  end

  def synth_get_pitch_wheel_sens( synth=self.synth, ch: , pval: )
    ret = C.fluid_synth_get_pitch_wheel_sens(synth, ch, pval)
    ret
  end

  def synth_get_program( synth=self.synth, ch: , sfid: , bknum: , prenum: )
    ret = C.fluid_synth_get_program(synth, ch, sfid, bknum, prenum)
    ret
  end

  #
  def synth_key_pressure( synth=self.synth, ch: , key: , val: )
    ret = C.fluid_synth_key_pressure(synth, ch, key, val)
    ret
  end

  # def synth_noteoff( synth: , ch: , key: )
  def synth_noteoff( synth=self.synth, ch: , key: )
    ret = nil
    if (key < 0 || key > 127) || (ch < 0)
      ret = FLUID_FAILED
    else
      ret = C.fluid_synth_noteoff(synth, ch, key)
    end
    ret
  end

  # def synth_noteon( synth: , ch: , key: , vel: )
  def synth_noteon( synth=self.synth, ch: , key: , vel: )
    ret = nil
    if (key < 0 || key > 127) || ch < 0 || (vel < 0 || vel > 127)
      ret = FLUID_FAILED
    else
      ret = C.fluid_synth_noteon(synth, ch, key, vel)
    end
    ret
  end

  #
  # ==== Args
  # val:: 8192 is the middle value (see the ref[1]).
  def synth_pitch_bend( synth=self.synth, ch: , val: )
    _val = val + 8192

    ret = C.fluid_synth_pitch_bend(synth, ch, _val)
    ret
  end

  # def synth_pitch_wheel_sens( synth: , ch: , val: )
  def synth_pitch_wheel_sens( synth=self.synth, ch: , val: )
    ret = C.fluid_synth_pitch_wheel_sens(synth, ch, val)
    ret
  end


  ### program.

  # def synth_program_change( synth: , ch: , prog_num: )
  def synth_program_change( synth=self.synth, ch: , pgnum: )
    ret = C.fluid_synth_program_change(synth, ch, pgnum)
    ret
  end

  def synth_program_reset( synth = self.synth )
    ret = C.fluid_synth_program_reset(synth)
    ret
  end
  # def synth_program_select( synth: , ch: , sfid: , bknum: , prenum: )
  def synth_program_select( synth=self.synth, ch: , sfid: , bknum: , prenum: )
    ret = C.fluid_synth_program_select(
            synth, ch, sfid, bknum, prenum)
    ret
  end

  def synth_program_select_by_sfont_name( synth=self.synth, ch: ,
                                          sfont_name: , bknum: , prenum: )
    ret = C.fluid_synth_program_select_by_sfont_name(
            synth, ch, sfont_name, bknum, prenum)
    ret
  end

  #
  # def synth_set_gen( synth: , ch: , param: , val: )
  def synth_set_gen( synth=self.synth, ch: , param: , val: )
    ret = C.fluid_synth_set_gen(synth, ch, param, val)
    ret
  end

  # def synth_sfont_select( synth: , ch: , sfid: )
  def synth_sfont_select( synth=self.synth, ch: , sfid: )
    ret = C.fluid_synth_sfont_select(synth, ch, sfid)
    ret
  end

  def synth_sysex( synth=self.synth,
                   data: , len: ,
                   response: , response_len: , handled: , dryrun: )
    ret = C.fluid_synth_sysex(synth, data,len,
                              response,response_len,
                              handled, dryrun)
    ret
  end

  def synth_system_reset( synth = self.synth )
    ret = C.fluid_synth_system_reset(synth)
    ret
  end

  def synth_unset_program( synth=self.synth, ch: )
    ret = C.fluid_synth_unset_program(synth, ch)
    ret
  end


end


#### endof filename: synth/midi/messages.rb
