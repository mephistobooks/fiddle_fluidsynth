#
# filename: soundfonts/generators.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions and defines for SoundFont generator effects.
  # ==== References
  # - API Reference, SoundFonts/[SoundFonts Generators](https://www.fluidsynth.org/api/group__generators.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #


  # Enumerations.
  #
  #

  # Settings type.
  enum(
    :fluid_gen_type,
    GEN_STARTADDROFS:       nil,
    GEN_ENDADDROFS:         nil,
    GEN_STARTLOOPADDROFS:   nil,
    GEN_ENDLOOPADDROFS:     nil,
    GEN_STARTADDRCOARSEOFS: nil,
    GEN_MODLFOTOPITCH:      nil,
    GEN_VIBLFOTOPITCH:      nil,
    GEN_MODENVTOPITCH:      nil,
    GEN_FILTERFC:           nil,
    GEN_FILTERQ:            nil,
    GEN_MODLFOTOFILTERFC:   nil,
    GEN_MODENVTOFILTERFC:   nil,
    GEN_ENDADDRCOARSEOFS:   nil,
    GEN_MODLFOTOVOL:        nil,
    GEN_UNUSED1:            nil,
    GEN_CHORUSSEND:         nil,
    GEN_REVERBSEND:         nil,
    GEN_PAN:                nil,
    GEN_UNUSED2:            nil,
    GEN_UNUSED3:            nil,
    GEN_UNUSED4:            nil,
    GEN_MODLFODELAY:        nil,
    GEN_MODLFOFREQ:         nil,
    GEN_VIBLFODELAY:        nil,
    GEN_VIBLFOFREQ:         nil,
    GEN_MODENVDELAY:        nil,
    GEN_MODENVATTACK:       nil,
    GEN_MODENVHOLD:         nil,
    GEN_MODENVDECAY:        nil,
    GEN_MODENVSUSTAIN:      nil,
    GEN_MODENVRELEASE:      nil,
    GEN_KEYTOMODENVHOLD:    nil,
    GEN_KEYTOMODENVDECAY:   nil,
    GEN_VOLENVDELAY:        nil,
    GEN_VOLENVATTACK:       nil,
    GEN_VOLENVHOLD:         nil,
    GEN_VOLENVDECAY:        nil,
    GEN_VOLENVSUSTAIN:      nil,
    GEN_VOLENVRELEASE:      nil,
    GEN_KEYTOVOLENVHOLD:    nil,
    GEN_KEYTOVOLENVDECAY:   nil,
    GEN_INSTRUMENT:         nil,
    GEN_RESERVED1:          nil,
    GEN_KEYRANGE:           nil,
    GEN_VELRANGE:           nil,
    GEN_STARTLOOPADDRCOARSEOFS: nil,
    GEN_KEYNUM:             nil,
    GEN_VELOCITY:           nil,
    GEN_ATTENUATION:        nil,
    GEN_RESERVED2:          nil,
    GEN_ENDLOOPADDRCOARSEOFS: nil,
    GEN_COARSETUNE:         nil,
    GEN_FINETUNE:           nil,
    GEN_SAMPLEID:           nil,
    GEN_SAMPLEMODE:         nil,
    GEN_RESERVED3:          nil,
    GEN_SCALETUNE:          nil,
    GEN_EXCLUSIVECLASS:     nil,
    GEN_OVERRIDEROOTKEY:    nil,
    GEN_PITCH:              nil,
    GEN_CUSTOM_BALANCE:     nil,
    GEN_CUSTOM_FILTERFC:    nil,
    GEN_CUSTOM_FILTERQ:     nil,
    GEN_LAST:               nil,
  )


  #
  module C

    # Enumerations.
    #
    #

    # not in here. under the FiddleFluidSynth directly.


    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #



  end

end


# Lifecycle Functions.
#
#


# Functions.
#
#


#### endof filename: soundfonts/generators.rb
