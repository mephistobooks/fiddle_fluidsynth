#
# filename: soundfonts/loader.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Create custom SoundFont loaders.
  # ==== References
  # - API Reference, SoundFont/[SoundFont Loader](https://www.fluidsynth.org/api/group__soundfont__loader.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Enumerations.
  #
  #

  #
  enum(
    FLUID_PRESET_SELECTED:    nil,
    FLUID_PRESET_UNSELECTED:  nil,
    FLUID_SAMPLE_DONE:        nil,
    FLUID_PRESET_PIN:         nil,
    FLUID_PRESET_UNPIN:       nil)

  # fluid_sample_type
  enum(
    :fluid_sample_type,
    FLUID_SAMPLETYPE_MONO:        0x1,
    FLUID_SAMPLETYPE_RIGHT:       0x2,
    FLUID_SAMPLETYPE_LEFT:        0x4,
    FLUID_SAMPLETYPE_LINKED:      0x8,
    FLUID_SAMPLETYPE_OGG_VORBIS:  0x10,
    FLUID_SAMPLETYPE_ROM:         0x8000)

  #
  module C

    # Typedefs.
    #
    #

    typealias 'fluid_preset_free_t',        'void*'
    typealias 'fluid_preset_get_banknum_t', 'void*'
    typealias 'fluid_preset_get_name_t',    'void*'
    typealias 'fluid_preset_get_num_t',     'void*'
    typealias 'fluid_preset_noteon_t',      'void*'

    #
    typealias 'fluid_sfloader_callback_close_t',  'void*'
    typealias 'fluid_sfloader_callback_open_t',   'void*'
    typealias 'fluid_sfloader_callback_read_t',   'void*'
    typealias 'fluid_sfloader_callback_seek_t',   'void*'
    typealias 'fluid_sfloader_callback_tell_t',   'void*'
    typealias 'fluid_sfloader_free_t',   'void*'
    typealias 'fluid_sfloader_load_t',   'void*'

    #
    typealias 'fluid_sfont_free_t',             'void*'
    typealias 'fluid_sfont_get_name_t',         'void*'
    typealias 'fluid_sfont_get_preset_t',       'void*'
    typealias 'fluid_sfont_iteration_next_t',   'void*'
    typealias 'fluid_sfont_iteration_start_t',  'void*'




    # Lifecycle Functions (SoundFont Loader).
    #
    #

    # Creates a new SoundFont loader.
    extern 'fluid_sfloader_t* new_fluid_sfloader' +
      '(fluid_sfloader_load_t*, fluid_sfloader_free_t*)'

    # Frees a SoundFont loader created with new_fluid_sfloader().
    extern 'void delete_fluid_sfloader(fluid_sfloader_t*)'

    # Creates a default soundfont2 loader that can be used with
    # fluid_synth_add_sfloader().
    extern 'fluid_sfloader_t* new_fluid_defsfloader(fluid_settings_t*)'


    # Lifecycle Functions (SoundFont).
    #
    #

    # Creates a new virtual SoundFont instance structure.
    extern 'fluid_sfont_t* new_fluid_sfont' +
      '(fluid_sfont_get_name_t, fluid_sfont_get_preset_t,' +
      ' fluid_sfont_iteration_start_t, fluid_sfont_iteration_next_t,' +
      ' fluid_sfont_free_t)'

    # Destroys a SoundFont instance created with new_fluid_sfont().
    extern 'int delete_fluid_sfont(fluid_sfont_t*)'


    # Lifecycle Functions (Preset).
    #
    #

    # Create a virtual SoundFont preset instance.
    extern 'fluid_preset_t* new_fluid_preset' +
      '(fluid_sfont_t*, fluid_preset_get_name_t*,' +
      ' fluid_preset_get_banknum_t, fluid_preset_get_num_t,' +
      ' fluid_preset_noteon_t, fluid_preset_free_t)'

    # Destroys a SoundFont preset instance created with new_fluid_preset().
    extern 'void delete_fluid_preset(fluid_preset_t*)'


    # Lifecycle Functions (Sample).
    #
    #

    # Create a new sample instance.
    extern 'fluid_sample_t* new_fluid_sample(void)'

    # Destroy a sample instance previously created with new_fluid_sample().
    extern 'void delete_fluid_sample(fluid_sample_t*)'


    # Functions.
    #
    #

    # Retrieves the presets bank number by executing the get_bank function
    # provided on its creation.
    extern 'int fluid_preset_get_banknum(fluid_preset_t*)'

    # Retrieve the private data of a SoundFont preset instance.
    extern 'void* fluid_preset_get_data(fluid_preset_t*)'

    # Retrieves the presets name by executing the get_name function provided
    # on its creation.
    extern 'char* fluid_preset_get_name(fluid_preset_t*)'

    # Retrieves the presets (instrument) number by executing the get_num
    # function provided on its creation.
    extern 'int fluid_preset_get_num(fluid_preset_t*)'

    # Retrieves the presets parent SoundFont instance.
    extern 'fluid_sfont_t* fluid_preset_get_sfont(fluid_preset_t*)'

    # Set private data to use with a SoundFont preset instance.
    extern 'int fluid_preset_set_data(fluid_preset_t*, void*)'

    ### .

    # Set the loop of a sample.
    extern 'int fluid_sample_set_loop' +
      '(fluid_sample_t*, unsigned int, unsigned int)'

    # Set the name of a SoundFont sample.
    extern 'int fluid_sample_set_name(fluid_sample_t*, char*)'

    # Set the pitch of a sample.
    extern 'int fluid_sample_set_pitch(fluid_sample_t*, int, int)'

    # Assign sample data to a SoundFont sample.
    extern 'int fluid_sample_set_sound_data' +
      '(fluid_sample_t*, short*, char*,' +
      ' unsigned int, unsigned int, short)'

    # Returns the size of the fluid_sample_t structure.
    extern 'size_t fluid_sample_sizeof(void)'

    # Obtain private data previously set with fluid_sfloader_set_data().
    extern 'void* fluid_sfloader_get_data(fluid_sfloader_t*)'

    # Set custom callbacks to be used upon soundfont loading.
    extern 'int fluid_sfloader_set_callbacks' +
      '(fluid_sfloader_t*, fluid_sfloader_callback_open_t*,' +
      ' fluid_sfloader_callback_read_t*, fluid_sfloader_callback_seek_t*,' +
      ' fluid_sfloader_callback_tell_t*, fluid_sfloader_callback_close_t*)'

    # Specify private data to be used by fluid_sfloader_load_t.
    extern 'int fluid_sfloader_set_data(fluid_sfloader_t*, void*)'

    ### .

    # Retrieve the private data of a SoundFont instance.
    extern 'void* fluid_sfont_get_data(fluid_sfont_t*)'

    # Retrieve the unique ID of a SoundFont instance.
    extern 'int fluid_sfont_get_id(fluid_sfont_t*)'

    # Retrieve the name of a SoundFont instance.
    extern 'char* fluid_sfont_get_name(fluid_sfont_t*)'

    # Retrieve the preset assigned the a SoundFont instance for the
    # given bank and preset number.
    extern 'fluid_preset_t* fluid_sfont_get_preset(fluid_sfont_t*, int, int)'

    # Virtual SoundFont preset iteration function.
    extern 'fluid_preset_t* fluid_sfont_iteration_next(fluid_sfont_t*)'

    # Starts / re-starts virtual preset iteration in a SoundFont.
    extern 'void fluid_sfont_iteration_start(fluid_sfont_t*)'

    # Set private data to use with a SoundFont instance.
    extern 'int fluid_sfont_set_data(fluid_sfont_t*, void*)'

    ### .

    # Add a SoundFont loader to the synth.
    extern 'void fluid_synth_add_sfloader(fluid_synth_t*, fluid_sfloader_t*)'

    # Get active preset on a MIDI channel.
    extern 'fluid_preset_t* fluid_synth_get_channel_preset(fluid_synth_t*, int)'


  end
end


#
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF
  end
  extend  SoundFontsLoaderIF
  include SoundFontsLoaderIF
end


# Lifecycle Functions (SoundFont Loader).
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF

    #
    def sfloader_new( load: , free: )
      ret = C.new_fluid_sfloader(load,free)
      ret
    end
    def defsfloader_new( settings )
      ret = C.new_fluid_defsfloader(settings)
      ret
    end
    def sfloader_delete( loader )
      ret = C.delete_fluid_sfloader(loader)
      ret
    end

  end
end

# Lifecycle Functions (SoundFont).
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF

    #
    # ==== See Also
    # - `#preset_get_sfont()`
    # - synth/soundfont_management.rb:`#synth_get_sfont()`
    # - synth/soundfont_management.rb:`#synth_get_sfont_by_id()`
    # - synth/soundfont_management.rb:`#synth_get_sfont_by_name()`
    #
    # def sfont_new( get_name: , get_preset: , iter_start: , iter_next: , free: )
    def sfont_new( get_name: nil, get_preset: nil,
                   iter_start: nil, iter_next: nil, free: nil )
      ret = C.new_fluid_sfont(
              get_name, get_preset, iter_start, iter_next, free)
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont)
      end
      ret
    end
    def sfont_delete( sfont )
      ret = C.delete_fluid_sfont(sfont)
      ret
    end

  end
end

# Lifecycle Functions (Preset).
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF

    #
    # ==== See Also
    # - `#sfont_get_preset()`
    #
    def preset_new( get_name: nil, get_preset: nil,
                    iter_start: nil, iter_next: nil, noteon: nil, 
                    free: nil )
      ret = C.new_fluid_preset(
              get_name, get_preset, iter_start, iter_next, noteon, free)
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont::Preset)
      end
      ret
    end
    def preset_delete( preset )
      ret = C.delete_fluid_preset(preset)
      ret
    end

  end
end

# Lifecycle Functions (Sample).
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF

    def sample_new( )
      ret = C.new_fluid_sample()
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont::Sample)
      end
      ret
    end
    def sample_delete( sample )
      ret = C.delete_fluid_sample(sample)
      ret
    end

  end
end


# Functions.
#
#
class FiddleFluidSynth
  module SoundFontsLoaderIF

    # for Preset.
    def preset_get_banknum( preset )
      ret = C.fluid_preset_get_banknum(preset)
      ret
    end
    alias preset_get_bknum preset_get_banknum

    def preset_get_data( preset )
      ret = C.fluid_preset_get_data(preset)
      ret
    end
    def preset_get_name( preset )
      # ret = C.fluid_preset_get_name(preset)
      ret = C.fluid_preset_get_name(preset).to_s
      ret
    end
    def preset_get_num( preset )
      ret = C.fluid_preset_get_num(preset)
      ret
    end

    #
    # ==== See Also
    # - `#sfont_new()`
    #
    def preset_get_sfont( preset )
      ret = C.fluid_preset_get_sfont(preset)
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont)
      end
      ret
    end
    def preset_set_data( preset, data: )
      ret = C.fluid_preset_set_data(preset,data)
      ret
    end

    # for Sample.
    def sample_set_loop( sample, loop_start: , loop_end: )
      ret = C.fluid_sample_set_loop(sample,loop_start,loop_end)
      ret
    end
    def sample_set_name( sample, name: )
      ret = C.fluid_sample_set_name(sample,name)
      ret
    end
    def sample_set_pitch( sample, root_key: , fine_tune: )
      ret = C.fluid_sample_set_pitch(sample,root_key,fine_tune)
      ret
    end
    def sample_set_sound_data( sample,
                               data: , data24: ,
                               nbframes: , sample_rate: , copy_data: )
      ret = C.sample_preset_set_sound_data(
        sample,data,data24,nbframes,sample_rate,copy_data)
      ret
    end

    #
    def sample_sizeof()
      ret = C.fluid_sample_sizeof()
      ret
    end

  end
end


class FiddleFluidSynth
  module SoundFontsLoaderIF

    # for sfloader.
    def sfloader_get_data( loader )
      ret = C.fluid_sfloader_get_data(loader)
      ret
    end

    def sfloader_set_callbacks( loader, open: , read: , seek: , tell: , close: )
      ret = C.fluid_sfloader_set_callbacks(loader,open,read,seek,tell,close)
      ret
    end

    #
    def sfloader_set_data( loader, data: )
      ret = C.fluid_sfloader_set_data(loader,data)
      ret
    end

    # for SoundFont.
    def sfont_get_data( sfont = self.sfont )
      ret = C.fluid_sfont_get_data(sfont)
      ret
    end
    def sfont_get_id( sfont = self.sfont )
      ret = C.fluid_sfont_get_id(sfont)
      ret
    end
    def sfont_get_name( sfont = self.sfont )
      ret = C.fluid_sfont_get_name(sfont).to_s
      ret
    end

    #
    # ==== See Also
    # - `#preset_new()`
    #
    # def sfont_get_preset( sfont, bknum: , prenum: )
    def sfont_get_preset( sfont = self.sfont, bknum: , prenum:  )
      ret = C.fluid_sfont_get_preset(sfont, bknum, prenum)
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont::Preset)
      end
      ret
    end

    #
    def sfont_iteration_next( sfont = self.sfont )
      ret = C.fluid_sfont_iteration_next(sfont)
      #ng. if ret.null? || ret.nil?
      if ret.nil? || ret.null?
        ret = nil
      else
        ret.extend(Interface::SoundFont::Preset)
      end
      ret
    end
    def sfont_iteration_start( sfont = self.sfont )
      ret = C.fluid_sfont_iteration_start(sfont)
      ret
    end
    def sfont_set_data( sfont = self.sfont, data: )
      ret = C.fluid_sfont_set_data(sfont, data)
      ret
    end

    # synth...?
    def synth_add_sfloader( synth = self.synth, loader: )
      ret = C.fluid_synth_add_sfloader(synth, loader)
      ret
    end

    def synth_get_channel_preset( synth = self.synth, ch: )
      ret = C.fluid_synth_get_channel_preset(synth, ch)
      ret
    end

  end
end


#### endof filename: soundfonts/loader.rb
