#
# filename: fiddle-fluidstynth/audio_output/file_renderer.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for managing file renderers and triggering the rendering.
  # ==== References
  # - Audio Output/[File Renderer](https://www.fluidsynth.org/api/group__file__renderer.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C


    # Lifecycle Functions.
    #
    #
    extern 'fluid_file_renderer_t* new_fluid_file_renderer(fluid_synth_t*)'
    extern 'void delete_fluid_file_renderer(fluid_file_renderer_t*)'

    # Functions.
    #
    #
    extern 'int fluid_file_renderer_process_block(fluid_file_renderer_t*)'
    extern 'int fluid_file_set_encoding_quality(fluid_file_renderer_t*, double)'

  end
end


#
#
#
class FiddleFluidSynth

  # Create a new file renderer and open the file.
  #def self.file_renderer_new( synth: )
  def self.file_renderer_new( synth )
    ret = C.new_fluid_file_renderer(synth)
    ret
  end
  # def file_renderer_new( synth: self.synth )
  def file_renderer_new( synth = self.synth )
    self.class.file_renderer_new(synth)
  end

  # Close file and destroy a file renderer object.
  def self.file_renderer_delete( dev )
    ret = C.delete_fluid_file_renderer(dev)
    ret
  end
  def file_renderer_delete( dev = self.file_renderer )
    self.class.file_renderer_delete(dev)
  end

end

#
#
#
class FiddleFluidSynth

  # Write period_size samples to file.
  def file_renderer_process_block( dev )
    ret = C.fluid_file_renderer_process_block(dev)
    ret
  end

  # Set vbr encoding quality (only available with libsndfile support)
  def file_renderer_set_encoding_quality( dev: , q: )
    ret = C.fluid_file_set_encoding_quality(dev, q)
    ret
  end

end


#### endof filename: fiddle-fluidstynth/audio_output/file_renderer.rb
