#
# filename: fiddle-fluidsynth/synth/soundfont_management.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions to load and unload SoundFonts.
  # ==== References
  # - API Reference, Synthesizer/[SoundFont Management](https://www.fluidsynth.org/api/group__audio__rendering.html)
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

    # Add a SoundFont.
    extern 'int fluid_synth_add_sfont(fluid_synth_t*, void*)'

    # Get bank offset of a loaded SoundFont.
    extern 'int fluid_synth_get_bank_offset(fluid_synth_t*, int)'

    # Get SoundFont by index.
    extern 'fluid_sfont_t* fluid_synth_get_sfont(fluid_synth_t*, unsigned int)'

    # Get SoundFont by ID.
    extern 'fluid_sfont_t* fluid_synth_get_sfont_by_id(fluid_synth_t*, int)'

    # Get SoundFont by name.
    extern 'fluid_sfont_t* fluid_synth_get_sfont_by_name(fluid_synth_t*, char*)'

    # Remove a SoundFont from the SoundFont stack without deleting it.
    extern 'int fluid_synth_remove_sfont(fluid_synth_t*, fluid_sfont_t*)'

    # Offset the bank numbers of a loaded SoundFont, i.e. subtract offset
    # from any bank number when assigning instruments.
    extern 'int fluid_synth_set_bank_offset(fluid_synth_t*, int, int)'

    # Count number of loaded SoundFont files.
    extern 'int fluid_synth_sfcount(fluid_synth_t*)'

    # Load a SoundFont file (filename is interpreted by SoundFont loaders).
    extern 'int fluid_synth_sfload(fluid_synth_t*, char*, int)'

    # Reload a SoundFont.
    extern 'int fluid_synth_sfreload(fluid_synth_t*, int)'

    # Schedule a SoundFont for unloading.
    extern 'int fluid_synth_sfunload(fluid_synth_t*, int, int)'

  end
end


#
#
#
class FiddleFluidSynth
  module Interface
    module SoundFont; end
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
  def synth_add_sfont( synth=self.synth, sfont: )
    ret = C.fluid_synth_add_sfont(synth,sfont)
    ret
  end

  def synth_get_bank_offset( synth=self.synth, sfid: )
    ret = C.fluid_synth_get_bank_sfont(synth, sfid)
    ret
  end

  def synth_get_sfont( synth=self.synth, num: )
    ret = C.fluid_synth_get_sfont(synth, num)
    ret.extend(Interface::SoundFont)
    ret
  end

  # def synth_get_sfont_by_id( synth: , id: )
  def synth_get_sfont_by_id( synth=self.synth, id: )
    ret = C.fluid_synth_get_sfont_by_id(synth, id)
    ret.extend(Interface::SoundFont)
    ret
  end

  def synth_get_sfont_by_name( synth=self.synth, name: )
    ret = C.fluid_synth_get_sfont_by_name(synth, name)
    ret.extend(Interface::SoundFont)
    ret
  end

  #
  def synth_remove_sfont( synth=self.synth, sfont: )
    ret = C.fluid_synth_remove_sfont(synth,sfont)
    ret
  end

  #
  def synth_set_bank_offset( synth=self.synth, sfid: , offset: )
    ret = C.fluid_synth_set_bank_offset(synth, sfid, offset)
    ret
  end

  #
  # ==== See Also
  # - #synth_sfload()
  #
  def synth_sfcount( synth = self.synth )
    ret = C.fluid_synth_sfcount(synth)
    ret
  end

  #
  # def synth_sfload( synth: , filename: , reset_presets: )
  def synth_sfload( synth=self.synth,
                    filename: , reset_presets: self.reset_presets,
                    verbose_f: false )
    #
    $stderr.print "(**) loading SoundFont: #{filename}..." if verbose_f
    if reset_presets
      _reset_presets = 1
    else
      _reset_presets = 0
    end

    ret = C.fluid_synth_sfload(synth,filename, _reset_presets)
    if ret == FLUID_FAILED
      $stderr.puts
      raise "Cannot load soundfont: #{self.soundfont_full_path}"
    else
      $stderr.puts " ok (#{ret})."
    end

    @sfid_last = ret
    @sfid_ary << @sfid_last

    $stderr.puts "(**) @sfid_ary: #{@sfid_ary} (SoundFont count:" +
      " #{self.synth_sfcount(synth)}/synth: 0x#{synth.to_i.to_s(16)})" if verbose_f

    ret
  end

  def synth_sfreload( synth=self.synth, id: self.sfid)
    ret = C.fluid_synth_sfreload(synth,id)
    ret
  end

  def synth_sfunload( synth=self.synth, id: self.sfid,
                      reset_presets: self.reset_presets )
    ret = C.fluid_synth_sfunload(synth,id,reset_presets)
    ret
  end


end


#### endof filename: fiddle-fluidsynth/synth/soundfont_management.rb
