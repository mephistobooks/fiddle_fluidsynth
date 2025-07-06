#
# filename: fiddle-fluidsynth/synth/midi/setup.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # The functions in this section provide interfaces to change the channel
  # type and to configure basic channels, legato and portamento setups.
  # ==== References
  # - API Reference, Synthesizer/[MIDI Channel Setup](https://www.fluidsynth.org/api/group__channel__setup.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Enumerators.
  #
  #

  ### Channel Type

  # The midi channel type used by fluid_synth_set_channel_type().
  enum(
    :fluid_midi_channel_type,
    CHANNEL_TYPE_MELODIC: 0,
    CHANNEL_TYPE_DRUM:    1,
  )

  ### Basic Channel Mode.

  # Channel mode bits OR-ed together so that it matches with the midi spec:
  # poly omnion (0), mono omnion (1), poly omnioff (2), mono omnioff (3).
  enum(
    :fluid_channel_mode_flags,
    FLUID_CHANNEL_POLY_OFF: 0x01,
    FLUID_CHANNEL_OMNI_OFF: 0x02)

  # Indicates the mode a basic channel is set to.
  FLUID_CHANNEL_MODE_MASK_EXT=(FLUID_CHANNEL_OMNI_OFF|FLUID_CHANNEL_POLY_OFF)
  enum(
    :fluid_basic_channel_modes,
    FLUID_CHANNEL_MODE_MASK:  FLUID_CHANNEL_MODE_MASK_EXT,
    FLUID_CHANNEL_MODE_OMNION_POLY:   FLUID_CHANNEL_MODE_MASK_EXT &
                                        (~FLUID_CHANNEL_OMNI_OFF&
                                         ~FLUID_CHANNEL_POLY_OFF),
    FLUID_CHANNEL_MODE_OMNION_MONO:   FLUID_CHANNEL_MODE_MASK_EXT &
                                        (~FLUID_CHANNEL_OMNI_OFF&
                                         FLUID_CHANNEL_POLY_OFF),
    FLUID_CHANNEL_MODE_OMNIOFF_POLY:  FLUID_CHANNEL_MODE_MASK_EXT &
                                        (FLUID_CHANNEL_OMNI_OFF&
                                         ~FLUID_CHANNEL_POLY_OFF),
    FLUID_CHANNEL_MODE_OMNIOFF_MONO:  FLUID_CHANNEL_MODE_MASK_EXT &
                                        (FLUID_CHANNEL_OMNI_OFF|
                                         FLUID_CHANNEL_POLY_OFF),
    FLUID_CHANNEL_MODE_LAST: nil,
  )

  ### Legato Mode.

  # Indicates the legato mode a channel is set to n1,n2,n3,.
  enum(
    :fluid_channel_legato_mode,
    FLUID_CHANNEL_LEGATO_MODE_RETRIGGER:       nil,
    FLUID_CHANNEL_LEGATO_MODE_MULTI_RETRIGGER: nil,
    FLUID_CHANNEL_LEGATO_MODE_LAST:            nil)

  ### Portamento Mode.

  # Indicates the portamento mode a channel is set to.
  enum(
    :fluid_channel_portamento_mode,
    FLUID_CHANNEL_PORTAMENTO_MODE_EACH_NOTE:      nil,
    FLUID_CHANNEL_PORTAMENTO_MODE_LEGATO_ONLY:    nil,
    FLUID_CHANNEL_PORTAMENTO_MODE_STACCATO_ONLY:  nil,
    FLUID_CHANNEL_PORTAMENTO_MODE_LAST:           nil)

  ### Breath Mode.

  # Indicates the breath mode a channel is set to.
  enum(
    :fluid_channel_breath_flags,
    FLUID_CHANNEL_BREATH_POLY: 0x10,
    FLUID_CHANNEL_BREATH_MONO: 0x20,
    FLUID_CHANNEL_BREATH_SYNC: 0x40)


  #
  module C


    # Functions.
    #
    #

    ### Channel Type

    # Set midi channel type.
    extern 'int fluid_synth_set_channel_type(fluid_synth_t*, int, int)'


    ### Basic Channel Mode

    # Disables and unassigns all channels from a basic channel group.
    extern 'int fluid_synth_reset_basic_channel(fluid_synth_t*, int)'

    # Returns poly mono mode information of any MIDI channel.
    extern 'int fluid_synth_get_basic_channel' +
      '(fluid_synth_t*, int, int*, int*, int*)'

    # Sets a new basic channel group only.
    extern 'int fluid_synth_set_basic_channel(fluid_synth_t*, int, int, int)'


    # Legato Mode.
    #
    #

    # Sets the legato mode of a channel.
    extern 'int fluid_synth_set_legato_mode(fluid_synth_t*, int, int)'

    # Gets the legato mode of a channel.
    extern 'int fluid_synth_get_legato_mode(fluid_synth_t*, int, int*)'


    # Portamento Mode.
    #
    #

    # Sets the portamento mode of a channel.
    extern 'int fluid_synth_set_portamento_mode(fluid_synth_t*, int, int)'

    #  Gets the portamento mode of a channel.
    extern 'int fluid_synth_get_portamento_mode(fluid_synth_t*, int, int*)'


    # Breath Mode.
    #
    #


    # Sets the breath mode of a channel.
    extern 'int fluid_synth_set_breath_mode(fluid_synth_t*, int, int)'

    # Gets the breath mode of a channel.
    extern 'int fluid_synth_get_breath_mode(fluid_synth_t*, int, int*)'


  end
end


# Lifecycle Functions.
#
#


# Functions.
#
#
class FiddleFluidSynth

  # Channel Type
  #
  #
  def synth_set_channel_type( synth=self.synth, ch: , type: )
    ret = C.fluid_synth_set_channel_type(synth, ch, type)
    ret
  end

  # Basic Channel Mode.
  #
  #
  def synth_reset_basic_channel( synth=self.synth, ch: )
    ret = C.fluid_synth_reset_basic_channel(synth, ch)
    ret
  end

  #
  # ==== Args
  #
  def synth_get_basic_channel( synth=self.synth, ch: ,
                               basic_ch_out: , mode_out: ,
                               val_out: )
    ret = C.fluid_synth_get_basic_channel(
            synth, ch, basic_ch_out, mode_out, val_out)
    ret
  end
  def synth_set_basic_channel( synth=self.synth, ch: , mode: , val: )
    ret = C.fluid_synth_set_basic_channel(synth, ch, mode, val)
    ret
  end

  # Breath Mode.
  #
  #
  def synth_set_breath_mode( synth=self.synth, ch: , breath_mode: )
    ret = C.fluid_synth_set_breath_mode(synth, ch, breath_mode)
    ret
  end
  def synth_get_breath_mode( synth=self.synth, ch: , out_mode: )
    ret = C.fluid_synth_get_breath_mode(synth, ch, out_mode)
    ret
  end

  # Legato Mode.
  #
  #
  def synth_set_legato_mode( synth=self.synth, ch: , legato_mode: )
    ret = C.fluid_synth_set_legato_mode(synth, ch, legato_mode)
    ret
  end
  def synth_get_legato_mode( synth=self.synth, ch: , out_mode: )
    ret = C.fluid_synth_get_legato_mode(synth, ch, out_mode)
    ret
  end

  # Portamento Mode.
  #
  #
  def synth_set_portamento_mode( synth=self.synth, ch: , portamento_mode: )
    ret = C.fluid_synth_set_portamento_mode(synth, ch, portamento_mode)
    ret
  end
  def synth_get_portamento_mode( synth=self.synth, ch: , out_mode: )
    ret = C.fluid_synth_get_portamento_mode(synth, ch, out_mode)
    ret
  end


end


#### endof filename: fiddle-fluidsynth/synth/midi/setup.rb
