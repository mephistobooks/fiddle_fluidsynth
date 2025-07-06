# frozen_string_literal: true
#
# filename: soundfonts/soundfonts_test.rb
#

require "test_helper"
require "fiddle_fluidsynth"


#
#
#
class FiddleFluidSynth::SoundFontTest < Test::Unit::TestCase

  #
  def self.startup; end
  def self.shutdown
    FFS.raise_error_in_callback
  end

  #
  def setup
    # @ffs = FiddleFluidSynth.new
  end
  def teardown
    FFS.raise_error_in_callback
    # @ffs.delete()
  end

end


#
class FiddleFluidSynth::SoundFontTest

  #
  #
  #
  test "SoundFont/Generators - Constants: Enumerations" do

    #
    ret = FFS::Enum_fluid_gen_type
    exp = FFS::Enum_fluid_gen_type
    assert_equal exp, ret

    ret = FFS::GEN_LAST
    exp = FFS::Enum_fluid_gen_type::GEN_LAST
    assert_equal exp, ret

    tmp = [
      FFS::GEN_STARTADDROFS,
      FFS::GEN_ENDADDROFS,
      FFS::GEN_STARTLOOPADDROFS,
      FFS::GEN_ENDLOOPADDROFS,
      FFS::GEN_STARTADDRCOARSEOFS,
      FFS::GEN_MODLFOTOPITCH,
      FFS::GEN_VIBLFOTOPITCH,
      FFS::GEN_MODENVTOPITCH,
      FFS::GEN_FILTERFC,
      FFS::GEN_FILTERQ,
      #
      FFS::GEN_MODLFOTOFILTERFC,
      FFS::GEN_MODENVTOFILTERFC,
      FFS::GEN_ENDADDRCOARSEOFS,
      FFS::GEN_MODLFOTOVOL,
      FFS::GEN_UNUSED1,
      FFS::GEN_CHORUSSEND,
      FFS::GEN_REVERBSEND,
      FFS::GEN_PAN,
      #
      FFS::GEN_UNUSED2,
      FFS::GEN_UNUSED3,
      FFS::GEN_UNUSED4,
      FFS::GEN_MODLFODELAY,
      FFS::GEN_MODLFOFREQ,
      FFS::GEN_VIBLFODELAY,
      FFS::GEN_VIBLFOFREQ,
      FFS::GEN_MODENVDELAY,
      FFS::GEN_MODENVATTACK,
      FFS::GEN_MODENVHOLD,
      FFS::GEN_MODENVDECAY,
      FFS::GEN_MODENVSUSTAIN,
      FFS::GEN_MODENVRELEASE,
      FFS::GEN_KEYTOMODENVHOLD,
      FFS::GEN_KEYTOMODENVDECAY,
      #
      FFS::GEN_VOLENVDELAY,
      FFS::GEN_VOLENVATTACK,
      FFS::GEN_VOLENVHOLD,
      FFS::GEN_VOLENVDECAY,
      FFS::GEN_VOLENVSUSTAIN,
      FFS::GEN_VOLENVRELEASE,
      FFS::GEN_KEYTOVOLENVHOLD,
      FFS::GEN_KEYTOVOLENVDECAY,
      FFS::GEN_INSTRUMENT,
      FFS::GEN_RESERVED1,
      FFS::GEN_KEYRANGE,
      FFS::GEN_VELRANGE,
      FFS::GEN_STARTLOOPADDRCOARSEOFS,
      #
      FFS::GEN_KEYNUM,
      FFS::GEN_VELOCITY,
      FFS::GEN_ATTENUATION,
      FFS::GEN_RESERVED2,
      FFS::GEN_ENDLOOPADDRCOARSEOFS,
      FFS::GEN_COARSETUNE,
      FFS::GEN_FINETUNE,
      FFS::GEN_SAMPLEID,
      FFS::GEN_SAMPLEMODE,
      FFS::GEN_RESERVED3,
      FFS::GEN_SCALETUNE,
      FFS::GEN_EXCLUSIVECLASS,
      FFS::GEN_OVERRIDEROOTKEY,
      FFS::GEN_PITCH,
      FFS::GEN_CUSTOM_BALANCE,
      FFS::GEN_CUSTOM_FILTERFC,
      FFS::GEN_CUSTOM_FILTERQ,
      #
      FFS::GEN_LAST,
    ]
    ret = tmp
    exp = (0...(tmp.size)).to_a
    assert_equal exp, ret

  end

  #
  #
  #
  test "SoundFont/Loader - Constants: Enumerations" do

    #
    ret = FFS::Enum_fluid_sample_type
    exp = FFS::Enum_fluid_sample_type
    assert_equal exp, ret

    #
    ret = [
      FFS::FLUID_PRESET_SELECTED,
      FFS::FLUID_PRESET_UNSELECTED,
      FFS::FLUID_SAMPLE_DONE,
      FFS::FLUID_PRESET_PIN,
      FFS::FLUID_PRESET_UNPIN,
    ]
    exp = (0...5).to_a
    assert_equal exp, ret

    #
    ret = [
      FFS::FLUID_SAMPLETYPE_MONO,
      FFS::FLUID_SAMPLETYPE_RIGHT,
      FFS::FLUID_SAMPLETYPE_LEFT,
      FFS::FLUID_SAMPLETYPE_LINKED,
      FFS::FLUID_SAMPLETYPE_OGG_VORBIS,
      FFS::FLUID_SAMPLETYPE_ROM,
    ]
    exp = [ 0x1, 0x2, 0x4, 0x8, 0x10, 0x8000, ]
    assert_equal exp, ret

  end

  #
  #
  #
  test "SoundFont/Modulators - Constants: Enumerations" do

    #
    ret = FFS::Enum_fluid_mod_flags
    exp = FFS::Enum_fluid_mod_flags
    assert_equal exp, ret
    ret = FFS::Enum_fluid_mod_src
    exp = FFS::Enum_fluid_mod_src
    assert_equal exp, ret
    ret = FFS::Enum_fluid_mod_transforms
    exp = FFS::Enum_fluid_mod_transforms
    assert_equal exp, ret

    # fluid_mod_flags
    ret = [
      FFS::FLUID_MOD_POSITIVE,
      FFS::FLUID_MOD_NEGATIVE,
      FFS::FLUID_MOD_UNIPOLAR,
      FFS::FLUID_MOD_BIPOLAR,
      FFS::FLUID_MOD_LINEAR,
      FFS::FLUID_MOD_CONCAVE,
      FFS::FLUID_MOD_CONVEX,
      FFS::FLUID_MOD_SWITCH,
      FFS::FLUID_MOD_GC,
      FFS::FLUID_MOD_CC,
      FFS::FLUID_MOD_CUSTOM,
      FFS::FLUID_MOD_SIN,
    ]
    exp = [ 0, 1, 0, 2, 0,
            4, 8,12, 0,16,
            0x40, 0x80,
          ]
    assert_equal exp, ret

    # fluid_mod_src
    ret = [
      FFS::FLUID_MOD_NONE,
      FFS::FLUID_MOD_VELOCITY,
      FFS::FLUID_MOD_KEY,
      FFS::FLUID_MOD_KEYPRESSURE,
      FFS::FLUID_MOD_CHANNELPRESSURE,
      FFS::FLUID_MOD_PITCHWHEEL,
      FFS::FLUID_MOD_PITCHWHEELSENS,
    ]
    exp = [ 0, 2, 3, 10, 13, 14, 16, ]
    assert_equal exp, ret

    # fluid_mod_transforms
    ret = [
      FFS::FLUID_MOD_TRANSFORM_LINEAR,
      FFS::FLUID_MOD_TRANSFORM_ABS,
    ]
    exp = [ 0, 2, ]
    assert_equal exp, ret

  end

  #
  #
  #
  test "SoundFont/Voice Manipulation - Constants: Enumerations" do

    # fluid_voice_add_mod.
    ret = FFS::Enum_fluid_voice_add_mod
    exp = FFS::Enum_fluid_voice_add_mod
    assert_equal exp, ret

    ret = FFS::FLUID_VOICE_DEFAULT
    exp = FFS::Enum_fluid_voice_add_mod::FLUID_VOICE_DEFAULT
    assert_equal exp, ret

    ret = [
      FFS::FLUID_VOICE_OVERWRITE,
      FFS::FLUID_VOICE_ADD,
      FFS::FLUID_VOICE_DEFAULT,
    ]
    exp = (0...3).to_a
    assert_equal exp, ret

  end


end


#
#
#
class FiddleFluidSynth::SoundFontTest

  #
  #
  #
  test "each_preset" do
    ffs = FiddleFluidSynth.new(soundfont_name: 'GeneralUser-GS.sf2')

    ret = ffs.object.soundfont.name
    exp = /GeneralUser-GS\.sf2$/
    assert_match exp, ret

    #
    tmp_ary = []
    ffs.object.soundfont.each_preset{|preset|
      # tmp_ary << preset.name
      _name = ffs.preset_get_name(preset)
      tmp_ary << _name
    }

    ret = tmp_ary.size
    exp = 287
    assert_equal exp, ret

    ret = tmp_ary.first
    exp = "Grand Piano"
    assert_equal exp, ret

    ret = tmp_ary.last(2)
    exp = ["SFX", "CM-64/32L"]
    assert_equal exp, ret

    #
    ret = ffs.sfont.name
    exp = /GeneralUser-GS.sf2$/
    assert_match exp, ret

    ret = ffs.sfont.sfid
    exp = 1
    assert_equal exp, ret

    tmp_ary = []
    ffs.sfont.each_preset{|preset|
      tmp_ary << [preset.bknum, preset.prenum, preset.name]
    }
    ret = tmp_ary.size
    exp = 287
    assert_equal exp, ret

    ret = tmp_ary.first
    exp = [ 0, 0, "Grand Piano"]
    assert_equal exp, ret

    ret = tmp_ary.last(2)
    exp = [
      [128, 56, "SFX"], [128, 127, "CM-64/32L"], ]
    assert_equal exp, ret

    #
    ret = ffs.sfont.presets.size
    exp = 287
    assert_equal exp, ret

    ret = ffs.sfont.presets.first.sfont.name
    exp = /GeneralUser-GS.sf2$/
    assert_match exp, ret


    ffs.delete
  end

end


#### endof filename: soundfonts/soundfonts_test.rb
