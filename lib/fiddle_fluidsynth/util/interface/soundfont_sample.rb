#
# filename: util/interface/soundfont_sample.rb
#
require 'fiddle'
require 'fiddle/import'


#
#
#
class FiddleFluidSynth

  #
  module Interface
    module SoundFont
      module Sample; end
    end
  end

end


# SoundFont getters/setters.
#
#
module FiddleFluidSynth::Interface
  module SoundFont::Sample

    FFS = FiddleFluidSynth

    ### from soundfonts/loader.rb

    #
    def set_loop( loop_start: , loop_end: , _self: self.itself )
      FFS.sample_set_loop(_self, loop_start, loop_end)
    end
    def set_name( name, _self: self.itself )
      FFS.sample_set_name(_self, name: name)
    end

    def set_pitch( root_key: , fine_tune: , _self: self.itself )
      FFS.sample_set_pitch(_self, root_key: root_key, fine_tune: fine_tune)
    end

    def set_sound_data( data: , data24: ,
                        nbframes: , sample_rate: , copy_data: ,
                        _self: self.itself )
      FFS.sample_set_sound_data(
        _self, data: data, data24: data24,
        nbframes: nbframes, sample_rate: sample_rate, copy_data: copy_data)
    end

    def sizeof( _self: self.itself )
      FFS.sample_sizeof()
    end

  end
end


#### endof filename: util/interface/soundfont_sample.rb
