#
# filename: fiddle-fluidstynth/soundfonts/modulators.rb
#


# References
# - fluidstynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # SoundFont modulator functions and constants.
  # ==== References
  # - API Reference, SoundFont/[SoundFont Modulators](https://www.fluidsynth.org/api/group__modulators.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #


  # Enumerations.
  #
  #

  # Flags defining the polarity, mapping function and type of a modulator
  # source.
  enum(
    :fluid_mod_flags,
    FLUID_MOD_POSITIVE: 0,
    FLUID_MOD_NEGATIVE: 1,

    FLUID_MOD_UNIPOLAR: 0,
    FLUID_MOD_BIPOLAR:  2,

    FLUID_MOD_LINEAR:    0,
    FLUID_MOD_CONCAVE:   4,
    FLUID_MOD_CONVEX:    8,
    FLUID_MOD_SWITCH:   12,

    FLUID_MOD_GC:        0,
    FLUID_MOD_CC:       16,
    FLUID_MOD_CUSTOM: 0x40,
    FLUID_MOD_SIN:    0x80)

  # General controller (if FLUID_MOD_GC in flags). 
  enum(
    :fluid_mod_src,
    FLUID_MOD_NONE:              0,
    FLUID_MOD_VELOCITY:          2,
    FLUID_MOD_KEY:               3,
    FLUID_MOD_KEYPRESSURE:      10,
    FLUID_MOD_CHANNELPRESSURE:  13,
    FLUID_MOD_PITCHWHEEL:       14,
    FLUID_MOD_PITCHWHEELSENS:   16,
  )

  # Transform types for the SoundFont2 modulators as defined by
  # SoundFont 2.04 section 8.3.
  enum(
    :fluid_mod_transforms,
    FLUID_MOD_TRANSFORM_LINEAR: 0,
    FLUID_MOD_TRANSFORM_ABS:    2)


  #
  #
  #
  module C


    # Lifecycle Functions (MIDI Sequencer).
    #
    #

    # Create a new uninitialized modulator structure.
    extern 'fluid_mod_t* new_fluid_mod(void)'

    # Free a modulator structure.
    extern 'void delete_fluid_mod(fluid_mod_t*)'


    # Functions.
    #
    #

    # Clone the modulators destination, sources, flags and amount.
    extern 'void fluid_mod_clone(fluid_mod_t*, fluid_mod_t*)'

    # Get the scale amount from a modulator.
    extern 'double fluid_mod_get_amount(fluid_mod_t*)'

    # Get destination effect from a modulator.
    extern 'int fluid_mod_get_dest(fluid_mod_t*)'

    # Get primary source flags from a modulator.
    extern 'int fluid_mod_get_flags1(fluid_mod_t*)'

    # Get secondary source flags from a modulator.
    extern 'int fluid_mod_get_flags2(fluid_mod_t*)'

    # Get the primary source value from a modulator.
    extern 'int fluid_mod_get_source1(fluid_mod_t*)'

    # Get the secondary source value from a modulator.
    extern 'int fluid_mod_get_source2(fluid_mod_t*)'

    # Get the transform type of a modulator.
    extern 'int fluid_mod_get_transform(fluid_mod_t*)'

    # Check if the modulator has the given destination.
    extern 'int fluid_mod_has_dest(fluid_mod_t*, int)'

    # Check if the modulator has the given source.
    extern 'int fluid_mod_has_source(fluid_mod_t*, int, int)'

    # Set the scale amount of a modulator.
    extern 'void fluid_mod_set_amount(fluid_mod_t*, double)'

    # Set the destination effect of a modulator.
    extern 'void fluid_mod_set_dest(fluid_mod_t*, int)'

    # Set a modulator's primary source controller and flags.
    extern 'void fluid_mod_set_source1(fluid_mod_t*, int, int)'

    # Set a modulator's secondary source controller and flags.
    extern 'void fluid_mod_set_source2(fluid_mod_t*, int, int)'

    # Set the transform type of a modulator.
    extern 'void fluid_mod_set_transform(fluid_mod_t*, int)'

    # Returns the size of the fluid_mod_t structure.
    extern 'size_t fluid_mod_sizeof(void)'

    # Checks if two modulators are identical in sources, flags and destination.
    extern 'int fluid_mod_test_identity(fluid_mod_t*, fluid_mod_t*)'


  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  #
  def mod_new()
    ret = C.new_fluid_mod()
    ret
  end

  def mod_delete( mod )
    ret = C.delete_fluid_mod(mod)
    ret
  end


end

# Functions.
#
#
class FiddleFluidSynth

  #
  def mod_clone( mod, src: )
    ret = C.fluid_mod_clone(mod, src)
    ret
  end

  def mod_get_amount( mod )
    ret = C.fluid_mod_get_amount(mod)
    ret
  end

  def mod_get_dest( mod )
    ret = C.fluid_mod_get_dest(mod)
    ret
  end

  def mod_get_flags1( mod )
    ret = C.fluid_mod_get_flags1(mod)
    ret
  end
  def mod_get_flags2( mod )
    ret = C.fluid_mod_get_flags2(mod)
    ret
  end
  def mod_get_source1( mod )
    ret = C.fluid_mod_get_source1(mod)
    ret
  end
  def mod_get_source2( mod )
    ret = C.fluid_mod_get_source2(mod)
    ret
  end

  #
  def mod_get_transform( mod )
    ret = C.fluid_mod_get_transform(mod)
    ret
  end

  #
  def mod_has_dest( mod, gen: )
    ret = C.fluid_mod_has_dest(mod,gen)
    ret
  end
  def mod_has_source( mod, cc: , ctrl: )
    ret = C.fluid_mod_has_source(mod,cc,ctrl)
    ret
  end

  #
  def mod_set_amount( mod, amount: )
    ret = C.fluid_mod_set_amount(mod, amount)
    ret
  end
  def mod_set_dest( mod, dst: )
    ret = C.fluid_mod_set_dest(mod, dst)
    ret
  end
  def mod_set_source1( mod, src: , flags: )
    ret = C.fluid_mod_set_amount(mod, amount)
    ret
  end
  def mod_set_source2( mod, src: , flags: )
    ret = C.fluid_mod_set_amount(mod, amount)
    ret
  end
  def mod_set_transform( mod, type: )
    ret = C.fluid_mod_set_amount(mod, amount)
    ret
  end

  def mod_sizeof
    ret = C.fluid_mod_sizeof()
    ret
  end
  def mod_test_identity( mod1: , mod2: )
    ret = C.fluid_mod_test_identity(mod1, mod2)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/soundfonts/modulators.rb
