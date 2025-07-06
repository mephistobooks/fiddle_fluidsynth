#
# filename: synth/audio_rendering.rb
#


# References
# - fluidstynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  #
  module C

    # The functions in this section can be used to render audio directly
    # to memory buffers.
    # ==== References
    # - API Reference, Synthesizer/[Audio Rendering](https://www.fluidsynth.org/api/group__audio__rendering.html)
    # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
    #

    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Synthesize a block of floating point audio to separate audio buffers
    # (multi-channel rendering).
    # FIXME. float**
    extern 'int fluid_synth_nwrite_float' +
      '(fluid_synth_t*, int, void*, void*, void*, void*)'

    # Synthesize floating point audio to stereo audio channels (implements
    # the default interface fluid_audio_func_t).
    extern 'int fluid_synth_process' +
      '(fluid_synth_t*, int, int, void*, int, void*)'

    # Synthesize a block of floating point audio samples to audio buffers.
    extern 'int fluid_synth_write_float' +
      '(fluid_synth_t*, int, void*, int, int, void*, int, int)'

    # Synthesize a block of 16 bit audio samples to audio buffers.
    extern 'int fluid_synth_write_s16' +
      '(fluid_synth_t*, int, void*, int, int, void*, int, int)'

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
  def synth_nwrite_float( synth=self.synth,
                          len: , left: , right: , fx_left: , fx_right: )
    deprecated_msg_instead('fluid_synth_process()', meth: __method__)

    ret = C.fluid_synth_nwrite_float(
            synth, len, left,right, fx_left,fx_right)
    ret
  end

  def synth_process( synth=self.synth,
                     len: , nfx: , fx: , nout: , outbuf: )
    ret = C.fluid_synth_process(
            synth, len, nfx,fx, nout,outbuf)
    ret
  end

  def synth_write_float( synth=self.synth,
                         len: , lout: , loff: , lincr: ,
                                rout: , roff: , rincr: )
    ret = C.fluid_synth_write_float(
            synth, len, lout,loff,lincr, rout,roff,rincr )
    ret
  end

  def synth_write_s16( synth=self.synth,
                       len: , lout: , loff: , lincr: ,
                              rout: , roff: , rincr: )
    ret = C.fluid_synth_write_s16(
            synth, len, lout,loff,lincr, rout,roff,rincr)
    ret
  end


end


#### endof filename: synth/rendering.rb
