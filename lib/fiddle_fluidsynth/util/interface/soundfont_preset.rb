#
# filename: util/interface/soundfont_preset.rb
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
      module Preset; end
    end
  end

end


# SoundFont getters/setters.
#
#
module FiddleFluidSynth::Interface
  module SoundFont::Preset

    FFS = FiddleFluidSynth

    ### from soundfonts/loader.rb

    #
    def banknum( _self: self.itself )
      FFS.preset_get_banknum(_self)
    end
    alias bknum banknum

    #
    def data( _self: self.itself )
      FFS.preset_get_data(_self, data: data)
    end

    def set_data( data, _self: self.itself )
      FFS.preset_set_data(_self, data: data)
    end

    #
    def num( _self: self.itself )
      FFS.preset_get_num(_self)
    end
    alias prenum num

    #
    def name( _self: self.itself )
      FFS.preset_get_name(_self)
    end

    #
    def sfont( _self: self.itself )
      FFS.preset_get_sfont(_self)
    end
    alias soundfont sfont

  end
end


#### endof filename: util/interface/soundfont_preset.rb
