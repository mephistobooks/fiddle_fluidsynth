#
# filename: misc/misc.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Miscellaneous utility functions and defines.
  # ==== References
  # - [Miscellaneous](https://www.fluidsynth.org/api/group__misc.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # Value that indicates failure, used by most libfluidsynth functions.
  FLUID_FAILED = -1
  # Value that indicates success, used by most libfluidsynth functions.
  FLUID_OK     =  0

  # these constants are available via #version_str() and #version().
  # FLUIDSYNTH_VERSION = "2.4.6"
  # FLUIDSYNTH_VERSION_MAJOR = 2
  # FLUIDSYNTH_VERSION_MICRO = 4
  # FLUIDSYNTH_VERSION_MINOR = 6

  #
  module C


    # Functions.
    #
    #

    # Wrapper for free() that satisfies at least C90 requirements.
    extern 'void fluid_free(void*)'

    # Check if a file is a MIDI file.
    extern 'int fluid_is_midifile(char*)'

    # Check if a file is a SoundFont file.
    extern 'int fluid_is_soundfont(char*)'

    # Get FluidSynth runtime version.
    extern 'void fluid_version(int*, int*, int*)'

    # Get FluidSynth runtime version as a string.
    extern 'char* fluid_version_str(void)'

  end

end


#
#
#
class FiddleFluidSynth

  def self.free( ptr )
    ret = C.fluid_free(ptr)
    ret
  end
  def free( ptr )
    self.class.free(ptr)
  end

  def self.is_midifile( file )
    ret = C.fluid_is_midifile(file)
    ret
  end
  def is_midifile( file )
    self.class.is_midifile(file)
  end

  def self.is_midifile?( file )
    unless File.exist?(file)
      raise "No such file: #{file}"
    end

    #ng. self.is_midifile(file) == C::FLUID_OK
    self.is_midifile(file) != 0
  end
  def is_midifile?( file )
    self.class.is_midifile?(file)
  end


  ### SoundFont

  #
  def self.is_soundfont( file )
    ret = C.fluid_is_soundfont(file)
    ret
  end
  def is_soundfont( file )
    self.class.is_soundfont(file)
  end

  #
  def self.is_soundfont?( file )
    unless File.exist?(file)
      raise "No such file: #{file}"
    end

    # self.is_soundfont(file) == C::FLUID_OK
    self.is_soundfont(file) != 0
  end
  def is_soundfont?( file )
    self.class.is_soundfont?(file)
  end

  #
  def self.misc_version( major, micro, minor )
    ret = C.fluid_version(major, micro, minor)
    ret
  end
  def misc_version( major, micro, minor )
    self.class.misc_version(major, micro, minor)
  end

  def self.misc_version_str
    ret = C.fluid_version_str().to_s
    ret
  end
  def misc_version_str
    self.class.misc_version_str
  end

end

#
#
#
class FiddleFluidSynth

  def self.fluidsynth_version
    ver_maj = Fiddle::Pointer.malloc_i
    ver_mic = Fiddle::Pointer.malloc_i
    ver_min = Fiddle::Pointer.malloc_i

    misc_version(ver_maj, ver_mic, ver_min)
    tmp = [ver_maj, ver_mic, ver_min].map{|e| e.decode1_i }

    ret = tmp
    ret
  end
  def fluidsynth_version; self.class.fluidsynth_version; end

  def self.fluidsynth_version_str
    # ret = C.fluid_version_str()
    ret = misc_version_str()
    ret
  end
  def fluidsynth_version_str; self.class.fluidsynth_version_str; end


end


#### endof filename: misc/misc.rb
