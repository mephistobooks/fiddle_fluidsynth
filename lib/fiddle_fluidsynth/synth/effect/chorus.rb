#
# filename: fiddle-fluidstynth/synth/effect/chorus.rb
#


# References
# - fluidstynth.org, [MIDI Driver](https://www.fluidsynth.org/api/group__midi__driver.html)
#
class FiddleFluidSynth

  # Functions for configuring the built-in chorus effect.
  # ==== References
  # - API Reference, Synthesizer/[Effect - Chorus](https://www.fluidsynth.org/api/group__chorus__effect.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Enumerations
  #
  #
  enum(
    :fluid_chorus_mod,
    FLUID_CHORUS_MOD_SINE:      0,
    FLUID_CHORUS_MOD_TRIANGLE:  1)

  #
  module C

    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Enable or disable chorus on one or all groups.
    extern 'int fluid_synth_chorus_on(fluid_synth_t*, int, int)'

    # Get chorus depth of all fx groups.
    extern 'double fluid_synth_get_chorus_depth(fluid_synth_t*)'

    # Get chorus lfo depth of one or all fx groups.
    extern 'int fluid_synth_get_chorus_group_depth(fluid_synth_t*, int, void*)'

    # Get chorus output level of one or all fx groups.
    extern 'int fluid_synth_get_chorus_group_level(fluid_synth_t*, int, void*)'

    # Get chorus count nr of one or all fx groups.
    extern 'int fluid_synth_get_chorus_group_nr(fluid_synth_t*, int, void*)'

    # Get chorus waveform lfo speed of one or all fx groups.
    extern 'int fluid_synth_get_chorus_group_speed(fluid_synth_t*, int, void*)'

    # Get chorus waveform type of one or all fx groups.
    extern 'int fluid_synth_get_chorus_group_type(fluid_synth_t*, int, void*)'

    # Get chorus level of all fx groups.
    extern 'double fluid_synth_get_chorus_level(fluid_synth_t*)'

    # Get chorus voice number (delay line count) value of all fx groups.
    extern 'int fluid_synth_get_chorus_nr(fluid_synth_t*)'

    # Get chorus speed in Hz of all fx groups.
    extern 'double fluid_synth_get_chorus_speed(fluid_synth_t*)'

    # Get chorus waveform type of all fx groups.
    extern 'int fluid_synth_get_chorus_type(fluid_synth_t*)'


    ### setters.

    # Set chorus parameters to all fx groups.
    extern 'int fluid_synth_set_chorus' +
      '(fluid_synth_t*, int, double, double, double, int)'

    # Set the chorus depth of all groups.
    extern 'int fluid_synth_set_chorus_depth(fluid_synth_t*, double)'

    # Set chorus lfo depth to one or all chorus groups.
    extern 'int fluid_synth_set_chorus_group_depth(fluid_synth_t*, int, double)'

    # Set chorus output level to one or all chorus groups.
    extern 'int fluid_synth_set_chorus_group_level(fluid_synth_t*, int, double)'

    # Set chorus voice count nr to one or all chorus groups.
    extern 'int fluid_synth_set_chorus_group_nr(fluid_synth_t*, int, int)'

    # Set chorus lfo speed to one or all chorus groups.
    extern 'int fluid_synth_set_chorus_group_speed(fluid_synth_t*, int, double)'

    # Set chorus lfo waveform type to one or all chorus groups.
    extern 'int fluid_synth_set_chorus_group_type(fluid_synth_t*, int, int)'

    # Set the chorus level of all groups.
    extern 'int fluid_synth_set_chorus_level(fluid_synth_t*, double)'

    # Set the chorus voice count of all groups.
    extern 'int fluid_synth_set_chorus_nr(fluid_synth_t*, int)'

    # Enable or disable all chorus groups.
    extern 'void fluid_synth_set_chorus_on(fluid_synth_t*, int)'

    # Set the chorus speed of all groups.
    extern 'int fluid_synth_set_chorus_speed(fluid_synth_t*, double)'

    # Set the chorus type of all groups.
    extern 'int fluid_synth_set_chorus_type(fluid_synth_t*, int)'


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
  def synth_chorus_on( synth=self.synth, fx_group:, fx_on: )
    ret = C.fluid_synth_chorus_on(synth, fx_group, fx_on)
    ret
  end

  #
  def synth_get_chorus_depth( synth=self.synth )
    deprecated_msg_instead('synth_get_chorus_group_depth()', meth: __method__)
    ret = C.fluid_synth_get_chorus_depth(synth)
    ret
  end

  def synth_get_chorus_group_depth( synth=self.synth, fx_group: , depth_ms: )
    ret = C.fluid_synth_get_chorus_group_depth(synth, fx_group, fx_on)
    ret
  end

  def synth_get_chorus_group_level( synth=self.synth, fx_group: , level: )
    ret = C.fluid_synth_get_chorus_group_level(synth, fx_group, fx_on)
    ret
  end

  def synth_get_chorus_group_nr( synth=self.synth, fx_group: , nr: )
    ret = C.fluid_synth_get_chorus_group_nr(synth, fx_group, nr)
    ret
  end

  def synth_get_chorus_group_speed( synth=self.synth, fx_group: , speed: )
    ret = C.fluid_synth_get_chorus_group_speed(synth, fx_group, speed)
    ret
  end

  def synth_get_chorus_group_type( synth=self.synth, fx_group: , type: )
    ret = C.fluid_synth_get_chorus_group_level(synth, fx_group, fx_on)
    ret
  end

  def synth_get_chorus_level( synth=self.synth )
    deprecated_msg_instead('synth_get_chorus_group_level()', meth: __method__)
    ret = C.fluid_synth_get_chorus_level(synth)
    ret
  end

  def synth_get_chorus_nr( synth=self.synth )
    deprecated_msg_instead('synth_get_chorus_group_nr()', meth: __method__)
    ret = C.fluid_synth_get_chorus_nr(synth)
    ret
  end

  def synth_get_chorus_speed( synth=self.synth )
    deprecated_msg_instead('synth_get_chorus_group_speed()', meth: __method__)
    ret = C.fluid_synth_get_chorus_speed(synth)
    ret
  end

  def synth_get_chorus_type( synth=self.synth )
    deprecated_msg_instead('synth_get_chorus_group_type()', meth: __method__)
    ret = C.fluid_synth_get_chorus_type(synth)
    ret
  end


  ### setters.

  #
  def synth_set_chorus( synth=self.synth,
                        nr: , level: , speed: , depth_ms: , type: )
    deprecated_msg_instead(
      'the individual chorus setter functions', meth: __method__)
    ret = C.fluid_synth_set_chorus(synth, nr,level,speed,depth_ms,type)
    ret
  end

  #
  def synth_set_chorus_depth( synth=self.synth, depth_ms: )
    deprecated_msg_instead(
      'synth_set_chorus_group_depth()', meth: __method__)
    ret = C.fluid_synth_set_chorus_depth(synth, depth_ms)
    ret
  end
  def synth_set_chorus_level( synth=self.synth, level: )
    deprecated_msg_instead(
      'synth_set_chorus_group_level()', meth: __method__)
    ret = C.fluid_synth_set_chorus_level(synth, level)
    ret
  end
  def synth_set_chorus_nr( synth=self.synth, nr: )
    deprecated_msg_instead(
      'synth_set_chorus_group_nr()', meth: __method__)
    ret = C.fluid_synth_set_chorus_nr(synth, nr)
    ret
  end
  def synth_set_chorus_speed( synth=self.synth, speed: )
    deprecated_msg_instead(
      'synth_set_chorus_group_speed()', meth: __method__)
    ret = C.fluid_synth_set_chorus_speed(synth,speed)
    ret
  end
  def synth_set_chorus_type( synth=self.synth, type: )
    deprecated_msg_instead(
      'synth_set_chorus_group_type()', meth: __method__)
    ret = C.fluid_synth_set_chorus_type(synth, type)
    ret
  end

  #
  def synth_set_chorus_on( synth=self.synth, on: )
    deprecated_msg_instead(
      'synth_chorus_on()', meth: __method__)
    ret = C.fluid_synth_set_chorus_on(synth, on)
    ret
  end

  # for group.
  def synth_set_chorus_group_depth( synth=self.synth, fx_group: , depth_ms: )
    ret = C.fluid_synth_set_chorus_group_depth(synth, fx_group, depth_ms)
    ret
  end

  def synth_set_chorus_group_level( synth=self.synth, fx_group: , level: )
    ret = C.fluid_synth_set_chorus_group_level(synth, fx_group, level)
    ret
  end

  def synth_set_chorus_group_nr( synth=self.synth, fx_group: , nr: )
    ret = C.fluid_synth_set_chorus_group_nr(synth, fx_group, nr)
    ret
  end

  def synth_set_chorus_group_speed( synth=self.synth, fx_group: , speed: )
    ret = C.fluid_synth_set_chorus_group_speed(synth, fx_group, speed)
    ret
  end

  def synth_set_chorus_group_type( synth=self.synth, fx_group: , type: )
    ret = C.fluid_synth_set_chorus_group_type(synth, fx_group, type)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/synth/effect/chorus.rb
