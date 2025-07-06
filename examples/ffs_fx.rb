#!/usr/bin/env ruby
#
#

# Original comments:
# FluidSynth FX - An example of using effects with fluidsynth
#
# This code is in the public domain.
#
# To compile:
#   gcc -g -O -o fluidsynth_fx fluidsynth_fx.c -lfluidsynth
#
# To run
#   fluidsynth_fx soundfont gain
#
# [Peter Hanappe]
#

# fiddle_fluidsynth comments:
# `ffs_fx.rb` is fiddle_fluidsynth version of `fluidsynth_fx.c`.
# This code is also in the public domain.
#
# [YAMAMOTO, Masayuki]

#
require_relative "../lib/fiddle_fluidsynth"
#require "fiddle_fluidsynth"


#
# if ARGV.size != 2
unless (1..2).cover? ARGV.size
  $stderr.puts "ARGV (#{ARGV.size}): #{ARGV}"
  $stderr.puts "#{__FILE__} [SOUNDFONT] <GAIN>"
  exit 1
end
opt_idx = 0
$stderr.puts "ARGV (#{ARGV.size}): #{ARGV}"
if File.exist? ARGV[opt_idx]
  opt_idx += 1
end
gain = ARGV[opt_idx].to_f


# Original comments:
# This function implements the callback function of the audio driver
# (see new_fluid_audio_driver2 below). The data argument is a pointer
# to your private data structure. 'len' is the number of audio frames
# in the buffers. 'nfx' and 'nout' are the number of input and output
# audio buffers. 'fx' and 'out' are arrays of float buffers containing
# the audio. The audio driver fills zero-initializes those buffers.
# You are responsible for filling up those buffers, as the result will
# be sent to the sound card. This is usually done by asking the synth
# to fill those buffers appropriately using fluid_synth_process()
#
# NOTE: The API was designed to be generic. Audio driver may fill the
# buffers with audio input from the soundcard, rather than zeros.
FFS = FiddleFluidSynth
fs  = nil  # define later (FFS instance).
cb_ptr = FFS.define_audio_func{|data, len, nfx, fx, nout, outbuf|

  # FiddleFluidSynth comments:
  # BE CAREFUL! all variables in the arguments (esp. the pointers)
  # are in FFI, not in Fiddle!!!
  #

  usr_data = data
  # $stderr.puts "gain: #{gain}"

  #
  $stderr.puts "len: #{len}, nfx: #{nfx}, fx: #{fx.inspect}," +
    " nout: #{nout}, outbuf: #{outbuf.inspect}"

  if fx.null?
    # Original comments:
    # Note that some audio drivers may not provide buffers for effects like
    # reverb and chorus. In this case it's your decision what to do. If you
    # had called fluid_synth_process() like in the else branch below, no
    # effects would have been rendered. Instead, you may mix the effects
    # directly into the out buffers.

    $stderr.puts "fx is nil."
    $stderr.puts "#audio_channels: #{fs.synth_count_audio_channels(fs.synth)}"
    $stderr.puts "#audio_groups:   #{fs.synth_count_audio_groups(fs.synth)}"
    $stderr.puts "#effects_groups: #{fs.synth_count_effects_groups(fs.synth)}"

    fx_ptr     = Fiddle::Pointer.new(fx.address)
    outbuf_ptr = Fiddle::Pointer.new(outbuf.address)
    if fs.synth_process(fs.synth, len: len,
        nfx: nfx, fx: fx_ptr, nout: nout, outbuf: outbuf_ptr) != 
        FiddleFluidSynth::FLUID_OK
      $stderr.puts "(1) synth_process() is failed."
      return FiddleFluidSynth::FLUID_FAILED
    else
      $stderr.puts "(1) synth_process() is succeeded."
    end
  else
    # Original comments:
    # Call the synthesizer to fill the output buffers with its
    # audio output.

    # FiddleFluidSynth comments:
    # FiddleFluidSynth#synth_process() is wrapped by Fiddle, so we have to
    # use Fiddle::Pointer instead of FFI::Pointer...
    #

    #
    fx_ptr     = Fiddle::Pointer.new(fx.address)
    outbuf_ptr = Fiddle::Pointer.new(outbuf.address)
    if fs.synth_process(fs.synth, len: len,
        nfx: nfx, fx: fx_ptr, nout: nout, outbuf: outbuf_ptr) != 
        FiddleFluidSynth::FLUID_OK
      $stderr.puts "(2) synth_process() is failed."
      return FiddleFluidSynth::FLUID_FAILED
    else
      $stderr.puts "(2) synth_process() is succeeded."
    end
  end

  #
  # $stderr.puts "effector: start."
  ptr_size   = FFI.type_size(:pointer)
  float_size = FFI.type_size(:float)
  # raise SyntaxError, "test."

  out_ptr = outbuf
  fx_ptr  = fx

  # Original comments:
  # Apply your effects here. In this example, the gain is
  # applied to all the dry-audio output buffers.

  # for outbuf.
  # $stderr.puts "effector: out."
  nout.times do |_i|
    ch_ptr = out_ptr.get_pointer(_i * ptr_size)

    len.times do |_j|
      v  = ch_ptr.get_float(_j * float_size)
      nv = v*gain
      ch_ptr.put_float(_j*float_size, nv)
      # $stderr.puts "#{_j}: #{v} =>#{nv} (gain: #{gain})"
    end
  end


  # Original comments:
  # Apply the same effect to all available effect buffer.
  #

  # for fx.
  # $stderr.puts "effector: fx."
  nfx.times do |_i|
    ch_ptr = fx_ptr.get_pointer(_i * ptr_size)

    len.times do |_j|
      v = ch_ptr.get_float(_j * float_size)
      ch_ptr.put_float(_j*float_size, v*gain)
    end
  end

  #return FiddleFluidSynth::FLUID_OK  # LongJumpError.
  FiddleFluidSynth::FLUID_OK
}


# Original comments:
# Create the audio driver. As soon as the audio driver is
# created, the synthesizer can be played.

# FiddleFluidSynth comments:
# Create the audio driver in the initializer of FFS.
#
fs = if ARGV.size == 2
       FiddleFluidSynth.new(
         soundfont_full_path: ARGV[0],
         player_f: false,
         # audio_driver_new2_f: true,
         audio_driver_callback: cb_ptr)
     else
       FiddleFluidSynth.new(
         player_f: false,
         audio_driver_callback: cb_ptr)
     end

# Original comments:
# play a note.
#
fs.noteon(0, 60, 100)

#
print 'Press "Enter" to stop: '
$stdin.getc
fs.raise_error_in_callback
puts "done."

#
fs.delete

#### end.
