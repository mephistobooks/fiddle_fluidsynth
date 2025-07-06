#
# filename: synth/effect/reverb.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for configuring the built-in reverb effect.
  # ==== References
  # - API Reference, Synthesizer/[Effect - Reverb](https://www.fluidsynth.org/api/group__reverb__effect.html)
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

    # Get reverb damping of all fx groups.
    extern 'double fluid_synth_get_reverb_damp(fluid_synth_t*)'

    # get reverb damp of one or all groups.
    extern 'int fluid_synth_get_reverb_group_damp(fluid_synth_t*, int, double*)'

    # get reverb level of one or all groups.
    extern 'int fluid_synth_get_reverb_group_level(fluid_synth_t*, int, double*)'

    # get reverb roomsize of one or all groups.
    extern 'int fluid_synth_get_reverb_group_roomsize' +
      '(fluid_synth_t*, int, double*)'

    # get reverb width of one or all groups
    extern 'int fluid_synth_get_reverb_group_width' +
      '(fluid_synth_t*, int, double*)'

    # Get reverb level of all fx groups.
    extern 'double fluid_synth_get_reverb_level(fluid_synth_t*)'

    # Get reverb room size of all fx groups.
    extern 'double fluid_synth_get_reverb_roomsize(fluid_synth_t*)'

    # Get reverb width of all fx groups.
    extern 'double fluid_synth_get_reverb_width(fluid_synth_t*)'

    # Enable or disable reverb on one fx group unit.
    extern 'int fluid_synth_reverb_on(fluid_synth_t*, int, int)'

    # Set reverb parameters to all groups.
    extern 'int fluid_synth_set_reverb' +
      '(fluid_synth_t*, double, double, double, double)'

    # Set reverb damping of all groups.
    extern 'int fluid_synth_set_reverb_damp(fluid_synth_t*, double)'

    # Set reverb damp to one or all fx groups.
    extern 'int fluid_synth_set_reverb_group_damp(fluid_synth_t*, int, double)'

    # Set reverb level to one or all fx groups.
    extern 'int fluid_synth_set_reverb_group_level(fluid_synth_t*, int, double)'

    # Set reverb roomsize to one or all fx groups.
    extern 'int fluid_synth_set_reverb_group_roomsize' +
      '(fluid_synth_t*, int, double)'

    # Set reverb width to one or all fx groups.
    extern 'int fluid_synth_set_reverb_group_width(fluid_synth_t*, int, double)'

    # Set reverb level of all groups.
    extern 'int fluid_synth_set_reverb_level(fluid_synth_t*, double)'

    # Enable or disable reverb effect.
    extern 'void fluid_synth_set_reverb_on(fluid_synth_t*, int)'

    # Set reverb roomsize of all groups.
    extern 'int fluid_synth_set_reverb_roomsize(fluid_synth_t*, double)'

    # Set reverb width of all groups.
    extern 'int fluid_synth_set_reverb_width(fluid_synth_t*, double)'


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
  def synth_get_reverb_damp( synth=self.synth )
    deprecated_msg_instead('synth_get_reverb_group_damp()', meth: __method__)
    ret = C.fluid_synth_get_reverb_damp(synth)
    ret
  end
  def synth_get_reverb_level( synth=self.synth )
    deprecated_msg_instead('synth_get_reverb_group_level()', meth: __method__)
    ret = C.fluid_synth_get_reverb_level(synth)
    ret
  end
  def synth_get_reverb_roomsize( synth=self.synth )
    deprecated_msg_instead('synth_get_reverb_group_roomsize()', meth: __method__)
    ret = C.fluid_synth_get_reverb_roomsize(synth)
    ret
  end
  def synth_get_reverb_width( synth=self.synth )
    deprecated_msg_instead('synth_get_reverb_group_width()', meth: __method__)
    ret = C.fluid_synth_get_reverb_width(synth)
    ret
  end

  #
  def synth_get_reverb_group_damp( synth=self.synth, fx_group: , damping: )
    ret = C.fluid_synth_get_reverb_group_damp(synth,fx_group,damping)
    ret
  end
  def synth_get_reverb_group_level( synth=self.synth, fx_group: , level: )
    ret = C.fluid_synth_get_reverb_group_level(synth,fx_group,damping)
    ret
  end
  def synth_get_reverb_group_roomsize( synth=self.synth, fx_group: , roomsize: )
    ret = C.fluid_synth_get_reverb_group_roomsize(synth,fx_group,damping)
    ret
  end
  def synth_get_reverb_group_width( synth=self.synth, fx_group: , width: )
    ret = C.fluid_synth_get_reverb_group_width(synth,fx_group,damping)
    ret
  end

  #
  def synth_reverb_on( synth=self.synth, fx_group: , on: )
    ret = C.fluid_synth_reverb_on(synth,fx_group,on)
    ret
  end

  ### setters.
  def synth_set_reverb( synth=self.synth, roomsize: , damping: , width: , level: )
    deprecated_msg_instead('the individual setter functions', meth: __method__)
    ret = C.fluid_synth_set_reverb(synth,roomsize,damping,width,level)
    ret
  end

  #
  def synth_set_reverb_damp( synth=self.synth, damping: )
    deprecated_msg_instead('synth_set_reverb_group_damp()', meth: __method__)
    ret = C.fluid_synth_set_reverb_damp(synth,damping)
    ret
  end
  def synth_set_reverb_level( synth=self.synth, level: )
    deprecated_msg_instead('synth_set_reverb_group_level()', meth: __method__)
    ret = C.fluid_synth_set_reverb_level(synth,level)
    ret
  end
  def synth_set_reverb_on( synth=self.synth, inton: )
    deprecated_msg_instead('synth_reverb_on()', meth: __method__)
    ret = C.fluid_synth_set_reverb_roomsize(synth, inton)
    ret
  end
  def synth_set_reverb_roomsize( synth=self.synth, roomsize: )
    deprecated_msg_instead('synth_set_reverb_group_roomsize()', meth: __method__)
    ret = C.fluid_synth_set_reverb_roomsize(synth,roomsize)
    ret
  end
  def synth_set_reverb_width( synth=self.synth, width: )
    deprecated_msg_instead('synth_set_reverb_group_width()', meth: __method__)
    ret = C.fluid_synth_set_reverb_width(synth,width)
    ret
  end

  ### setters for group.
  def synth_set_reverb_group_damp( synth=self.synth, fx_group: , damping: )
    ret = C.fluid_synth_set_reverb_group_damp(synth,fx_group,damping)
    ret
  end
  def synth_set_reverb_group_level( synth=self.synth, fx_group: , level: )
    ret = C.fluid_synth_set_reverb_group_level(synth,fx_group,level)
    ret
  end
  def synth_set_reverb_group_roomsize( synth=self.synth, fx_group: , roomsize: )
    ret = C.fluid_synth_set_reverb_group_roomsize(synth,fx_group,roomsize)
    ret
  end
  def synth_set_reverb_group_width( synth=self.synth, fx_group: , width: )
    ret = C.fluid_synth_set_reverb_group_width(synth,fx_group,width)
    ret
  end


end


#### endof filename: synth/effect/reverb.rb
