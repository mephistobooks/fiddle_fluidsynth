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
    # ==== Args
    # bknum:: bank number.
    # prenum:: preset number.
    # ==== Returns
    # nil or Preset instance.
    def preset( bknum: , prenum: , _self: self.itself )
      FFS.sfont_get_preset(_self, bknum: bknum, prenum: prenum)
    end

    #
    def preset_iter_reset( _self: self.itself )
      FFS.sfont_iteration_start(_self)
    end

    def each_preset( _self: self.itself, debug_f: false, &blk )
      #
      # self.preset_iter_reset()
      self.preset_iter_reset(_self: _self)
      preset = nil
      cnt    = 0
      $stderr.puts "{#{__method__}} cnt: #{cnt}," +
        " preset: #{preset.inspect}"  if debug_f


      # until (preset = FFS.sfont_iteration_next(_self))&.null?
      # while (preset = FFS.sfont_iteration_next(_self))  # ok.
      #
      #ng. while (preset = FFS.sfont_iteration_next(_self),
      #        #(preset && !preset.null?))
      #        (preset))
      #ng. while ((preset = FFS.sfont_iteration_next(_self)),
      #        (preset && !preset.null?))
      #ng. while (preset = FFS.sfont_iteration_next(_self)),
      #    (preset && !preset.null?)

      while [preset = FFS.sfont_iteration_next(_self),
          (preset && !preset.null?)].last

        $stderr.puts "{#{__method__}} cnt: #{cnt}," +
          " preset: #{preset.inspect}:#{preset.class}," +
          " null?: #{preset.null?}" if debug_f

        blk.(preset)
        cnt += 1
      end
      $stderr.puts "{#{__method__}} LAST: cnt: #{cnt}," +
        " preset: #{preset.inspect}:#{preset.class}" if debug_f

      cnt
    end
    alias preset_iter each_preset

    def presets( _self: self.itself, debug_f: false )
      ret = []

      self.each_preset(debug_f: debug_f){|pres| ret << pres }
      $stderr.puts "{#{__method__}} ret (#{ret.size}):" +
        " #{ret.first.name} - #{ret.last.name}" if debug_f
      ret
    end
    alias all_presets presets

  end
end


#### endof filename: util/interface/soundfont.rb
