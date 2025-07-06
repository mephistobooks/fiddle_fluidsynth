#
# filename: fiddle-fluidstynth/command_interface/command_interface.rb
#


# References
# - [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Control and configuration interface.
  # ==== References
  # - API References, [Command Interface](https://www.fluidsynth.org/api/group__command__interface.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Functions.
    #
    #

    # Get standard in stream handle.
    extern 'fluid_istream_t fluid_get_stdin(void)'

    # Get standard output stream handle.
    extern 'fluid_ostream_t fluid_get_stdout(void)'

    # Get the system FluidSynth command file name.
    extern 'char* fluid_get_sysconf(char*, int)'

    # Get the user specific FluidSynth command file name.
    extern 'char* fluid_get_userconf(char*, int)'

  end
end


#
#
#
class FiddleFluidSynth

  def self.get_stdin
    ret = C.fluid_get_stdin()
    ret
  end
  def get_stdin
    self.class.get_stdin()
  end

  def self.get_stdout
    ret = C.fluid_get_stdout()
    ret
  end
  def get_stdout
    self.class.get_stdout()
  end

  #
  # ==== Args
  # buf:: Caller supplied string buffer to store file name to.
  # len:: Length of buf.
  #
  def self.get_sysconf( buf, len )
    ret = C.fluid_get_sysconf(buf, len)
    ret
  end
  def get_sysconf( buf, len )
    self.class.get_sysconf(buf, len)
  end

  #
  # ==== Args
  # buf:: Caller supplied string buffer to store file name to.
  # len:: Length of buf.
  #
  def self.get_userconf( buf, len )
    ret = C.fluid_get_userconf(buf, len)
    ret
  end
  def get_userconf( buf, len )
    self.class.get_userconf(buf, len)
  end

end


#### endof filename: fiddle-fluidstynth/command_interface/command_interface.rb
