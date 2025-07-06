#
# filename: util/interface/soundfont.rb
#
require 'fiddle'
require 'fiddle/import'


#
#
#
class FiddleFluidSynth

  #
  module Interface
    module SoundFont; end
  end

end


# SoundFont getters/setters.
#
#
module FiddleFluidSynth::Interface
  module SoundFont

    FFS = FiddleFluidSynth

    ### from soundfonts/loader.rb

    #
    def data( _self: self.itself )
      FFS.sfont_get_data(_self)
    end
    def set_data( data, _self: self.itself )
      FFS.sfont_set_data(_self, data: data)
    end

    def id( _self: self.itself )
      FFS.sfont_get_id(_self)
    end
    alias sfid id

    def name( _self: self.itself )
      FFS.sfont_get_name(_self)
    end

    #
    def preset( bknum: , prenum: , _self: self.itself )
      FFS.sfont_get_preset(_self, bknum: bknum, prenum: prenum)
    end

    def preset_iter_reset( _self: self.itself )
      FFS.sfont_iteration_start(_self)
    end

    def each_preset( _self: self.itself, &blk )
      self.preset_iter_reset()

      cnt  = 0
      # preset = self.sfont_iteration_next(_self)
      # cnt += 1

      preset = nil
      until (preset = FFS.sfont_iteration_next(_self))&.null?
        blk.(preset)
        # preset = self.sfont_iteration_next(_self)
        cnt += 1
      end
      cnt
    end

    def presets( _self: self.itself )
      ret = []

      self.each_preset{|pres| ret << pres }
      ret
    end
    alias all_presets presets

  end
end


#### endof filename: util/interface/soundfont.rb
