#
# filename: util/settings.rb
#
require 'fiddle'
require 'fiddle/import'


#
#
#
class FiddleFluidSynth

  #
  module Interface
    module Settings; end
  end

  #
  module Interface
    module AudioOutputDriver; end
  end

end


#
#
#
#class FiddleFluidSynth
#  module Interface::Settings
module FiddleFluidSynth::Interface
  module Settings

    #
    def self.item_to_meth_name( item )
      _item = item
      ret = _item.to_s.gsub(/(\w)[.](\w)/, '\1_\2').
              gsub(/(\w)[-](\w)/, '\1__\2')
      ret
    end
    #def item_to_meth_name( item )
    #def item_to_meth( item )
    def item_to_meth_name( item )
      #ng. self.class.send(__method__, item)
      #ng. self.class.item_to_meth_name(item)
      # Settings.item_to_meth_name(item)  # ok.
      Settings.send(__method__, item)
    end

  end
end


class FiddleFluidSynth
  module Interface::Settings

     #
    def self.define_accessors( item, debug_f: false )
      # dummy object for defining interface methods.
      settings_obj = FiddleFluidSynth.settings_new()

      type = ::FiddleFluidSynth::C.fluid_settings_get_type(settings_obj,item)
      $stderr.puts "{#{__method__}} item: #{item}, type: #{type}" if debug_f

      #
      mname_base = item_to_meth_name(item)
      mname_setter    = mname_base + "="
      mname_getter    = mname_base
      mname_default   = mname_base + "_default"
      mname_range     = mname_base + "_range"

      #
      mname_name = mname_base + "_name"
      define_method(mname_name){|_self: itself|
        ret = item
        ret
      }

      #
      case type
      when FiddleFluidSynth::FLUID_NUM_TYPE
        # setters.
        define_method(mname_setter){|dbl, _self: itself|
          _dbl = dbl
          rg = _self.send(mname_range)

          #
          if rg.nil?

          else
            if rg.cover?(_dbl)

            else
              _dbl = rg.first if _dbl < rg.first
              _dbl = rg.last  if rg.first < _dbl
              $stderr.puts "(**) value #{int} is out of range #{rg}." +
                " so fixed to #{_int}"
            end
          end

          ret = FiddleFluidSynth::C.fluid_settings_setnum(_self, item, _dbl)
          ret
        }

        # getters.
        define_method(mname_getter){|_self: itself|
          tmp = Fiddle::Pointer.malloc_dbl
          FiddleFluidSynth::C.fluid_settings_getnum(_self,item,tmp)
          ret = tmp.decode1_dbl
          ret
        }

        # default.
        define_method(mname_default){|_self: itself|
          ret = nil

          outval = Fiddle::Pointer.malloc_dbl
          tmp = FiddleFluidSynth::C.fluid_settings_getnum_default(
                  _self,item,outval)
          if FLUID_OK == tmp
            ret = outval.decode1_dbl
          else
            # do nothing.
          end

          ret
        }

        # range.
        define_method(mname_range){|_self: itself|
          ret = nil

          out_min = Fiddle::Pointer.malloc_dbl
          out_max = Fiddle::Pointer.malloc_dbl
          tmp = FiddleFluidSynth::C.fluid_settings_getnum_range(
                  _self,item,out_min,out_max)
          if FLUID_OK == tmp
            min = out_min.decode1_dbl
            max = out_max.decode1_dbl
            ret = min..max
          else
            # do nothing. (ret = nil)
          end
          ret
        }

      when FiddleFluidSynth::FLUID_INT_TYPE
        # setters.
        define_method(mname_setter){|int, _self: itself|
          _int = int
          rg = _self.send(mname_range)

          #
          if rg.nil?
            # nothing to do.
          else
            if rg.cover?(_int)
              # nothing to do.
            else
              _int = rg.first if _int < rg.first
              _int = rg.last  if rg.last < _int
              $stderr.puts "(**) value #{int} is out of range #{rg}." +
                " so fixed to #{_int}"
            end
          end

          ret = FiddleFluidSynth::C.fluid_settings_setint(_self, item, _int)
          ret
        }

        # getters.
        define_method(mname_getter){|_self: itself|
          tmp = Fiddle::Pointer.malloc_int
          FiddleFluidSynth::C.fluid_settings_getint(_self,item,tmp)
          ret = tmp.decode1_int
          ret
        }

        # default.
        define_method(mname_default){|_self: itself|
          ret = nil

          outval = Fiddle::Pointer.malloc_int
          tmp = FiddleFluidSynth::C.fluid_settings_getint_default(
                  _self, item, outval)
          if FLUID_OK == tmp
            ret = outval.decode1_int
          else
            #
          end

          ret
        }

        # range.
        define_method(mname_range){|_self: itself|
          ret = nil

          out_min = Fiddle::Pointer.malloc_int
          out_max = Fiddle::Pointer.malloc_int
          tmp = FiddleFluidSynth::C.fluid_settings_getint_range(
            _self,item, out_min, out_max)
          if FLUID_OK == tmp
            min = out_min.decode1_int
            max = out_max.decode1_int
            ret = min..max
          else
            #
          end

          ret
        }

      when FiddleFluidSynth::FLUID_STR_TYPE
        # setters.
        define_method(mname_setter){|str, _self: itself|
          FiddleFluidSynth::C.fluid_settings_setstr(_self, item, str)
        }

        # getters. STR_TYPE
        define_method(mname_getter){|_self: itself|
          ret = nil
          out = Fiddle::Pointer.malloc_voidp
          ret = FiddleFluidSynth.settings_dupstr(
                  settings: _self, name: item, out: out)
          ret
        }

        # default.
        define_method(mname_default){|_self: itself|
          ret = nil

          #
          outval = Fiddle::Pointer.malloc_voidp
          tmp = FiddleFluidSynth::C.fluid_settings_getstr_default(
                  _self, item, outval)
          # $stderr.puts "[DEBUG] outval: #{outval}, tmp: #{tmp}, ret: #{ret}"

          #
          if FLUID_OK == tmp
            cstr_ptr  = outval.ptr
            ret = (cstr_ptr.null?)? nil : cstr_ptr.to_s
          else
            $stderr.puts "(**) API returned FLUID_FAILED (#{tmp})"
          end

          ret
        }

        # range. STR_TYPE does NOT have the range.
        # FIXME. by optionlist?
        #
        # define_method(mname_range){|_self: itself|
        #   ret = nil
        #   out_min = Fiddle::Pointer.malloc_dbl
        #   out_max = Fiddle::Pointer.malloc_dbl
        #   tmp = FiddleFluidSynth::C.fluid_settings_getint_range(
        #     _self,item, out_min, out_max)
        #   if FLUID_OK == tmp
        #     min = out_min.decode1_dbl
        #     max = out_max.decode1_dbl
        #     ret = min..max
        #   else
        #     #
        #   end
        #   ret
        # }
        define_method(mname_range){|_self: itself|
          ret = nil
          $stderr.puts "(**) #{item} does NOT have the range."
          ret
        }


      else
        msg = ""
        if FLUID_NO_TYPE == type
          msg = "(**) item \"#{item}\" is FLUID_NO_TYPE (#{type}) in this" +
            " machine. So we do NOT define accessors for this..."
        else
          msg = "(**) Unknown type #{type} for item: #{item}."
        end

        $stderr.puts "#{msg}"
      end

      #
      FiddleFluidSynth.settings_delete(settings_obj)
    end

    #
    def value_of( name )
      meth_name = self.item_to_meth_name(name)
      ret = self.send(meth_name)
      ret
    end
    alias val_of  value_of
    alias value   value_of
    alias val     value_of
    alias get     value_of

  end
end


# Settings callback functions for iterators.
#
#
module FiddleFluidSynth::Interface
  module Settings

    def each_setting( data: nil, verbose_f: false, &blk )
      cb_ptr = FiddleFluidSynth.
        define_settings_foreach_callback(){|data,name,type|
          blk.call(data,name,type)
        }
      $stderr.puts "{#{__method__}} 0x#{cb_ptr.to_i.to_s(16)}" if verbose_f

      FiddleFluidSynth::C.
        fluid_settings_foreach(self,data,cb_ptr)
    end

    def each_option_of( setting_name, data: nil, verbose_f: false, &blk )
      cb_ptr = FiddleFluidSynth.
        define_settings_foreach_option_callback(){|_data,_name,_option|
          blk.call(_data,_name,_option)
        }
      $stderr.puts "{#{__method__}} 0x#{cb_ptr.to_i.to_s(16)}" if verbose_f

      FiddleFluidSynth::C.
        fluid_settings_foreach_option(self,setting_name,data,cb_ptr)
    end

  end
end


# Settings/Audio driver settings.
# ==== References
# - fluidsynth.org, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html).
#
module FiddleFluidSynth::Interface
  module Settings

    #
    [
      'audio.driver',
      'audio.periods',
      'audio.period-size',
      'audio.realtime-prio',
      'audio.sample-format',

      #
      'audio.alsa.device',

      #
      "audio.coreaudio.device",
      "audio.coreaudio.channel-map",

      #
      # "audio.driver",
      'audio.dart.device',

      #
      'audio.dsound.device',

      #
      "audio.file.endian",
      "audio.file.format",
      "audio.file.name",
      "audio.file.type",

      #
      'audio.jack.autoconnect',
      'audio.jack.id',
      'audio.jack.multi',
      'audio.jack.server',

      #
      'audio.oboe.id',
      'audio.oboe.sample-rate-conversion-quality',
      'audio.oboe.sharing-mode',
      'audio.oboe.performance-mode',
      'audio.oboe.error-recovery-mode',

      #
      'audio.oss.device',

      #
      'audio.pipewire.media-category',
      'audio.pipewire.media-role',
      'audio.pipewire.media-type',

      #
      'audio.portaudio.device',

      #
      'audio.pulseaudio.adjust-latency',
      'audio.pulseaudio.device',
      'audio.pulseaudio.media-role',
      'audio.pulseaudio.server',

      #
      'audio.sdl2.device',

      #
      'audio.wasapi.device',
      'audio.wasapi.exclusive-mode',

      #
      'audio.waveout.device',

    ].each do |item|
      define_accessors(item)
    end

  end
end

# Settings/MIDI driver settings.
# ==== References
# - fluidsynth.org, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html).
#
#
module FiddleFluidSynth::Interface

  module Settings

    #
    [
      "midi.autoconnect",
      "midi.driver",
      "midi.realtime-prio",
      "midi.portname",

      #
      "midi.alsa.device",
      "midi.alsa_seq.device",
      "midi.alsa_seq.id",

      #
      "midi.coremidi.id",

      #
      "midi.jack.server",
      "midi.jack.id",

      #
      "midi.oss.device",

      #
      "midi.winmidi.device",

    ].each do |_item|
      define_accessors(_item)
    end

  end

end

# Settings/MIDI player settings.
# ==== References
# - fluidsynth.org, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html).
#
module FiddleFluidSynth::Interface

  module Settings

    #
    [
      "player.reset-synth",
      "player.timing-source",
    ].each do |_item|
      define_accessors(_item)
    end

  end

end


# Settings/Shell (command line) settings.
# ==== References
# - fluidsynth.org, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html).
#
module FiddleFluidSynth::Interface

  module Settings

    #
    [
      "shell.port",
      "shell.prompt",
    ].each do |_item|
      define_accessors(_item)
    end

  end

end


# Settings/Synthesizer settings.
# ==== References
# - fluidsynth.org, [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html).
#
module FiddleFluidSynth::Interface

  module Settings

    #
    [
      #
      "synth.audio-channels",
      "synth.audio-groups",

      #
      "synth.chorus.active",
      "synth.chorus.depth",
      "synth.chorus.level",
      "synth.chorus.nr",
      "synth.chorus.speed",
      "synth.cpu-cores",

      #
      "synth.default-soundfont",
      "synth.device-id",
      "synth.dynamic-sample-loading",

      #
      "synth.effects-channels",
      "synth.effects-groups",

      #
      "synth.gain",

      #
      "synth.ladspa.active",
      "synth.lock-memory",

      #
      "synth.midi-channels",
      "synth.midi-bank-select",
      "synth.min-note-length",

      #
      "synth.note-cut",

      #
      "synth.overflow.age",
      "synth.overflow.important",
      "synth.overflow.important-channels",
      "synth.overflow.percussion",
      "synth.overflow.released",
      "synth.overflow.sustained",
      "synth.overflow.volume",

      #
      "synth.polyphony",

      #
      "synth.reverb.active",
      "synth.reverb.damp",
      "synth.reverb.level",
      "synth.reverb.room-size",
      "synth.reverb.width",

      #
      "synth.sample-rate",

      #
      "synth.threadsafe-api",

      #
      "synth.verbose",

    ].each do |_item|
      define_accessors(_item)
    end

  end

end


#
#
#
module FiddleFluidSynth::Interface
  module Settings
    FFS = FiddleFluidSynth


    ### type.

    def type_of( name, _self: self.itself )
      ret = FFS.settings_get_type(name, settings: _self)
      ret
    end
    alias type type_of

    #def type_is_notype?( name,
    #                     _self: self.itself ,
    #                     type: self.type_of(name, _self: _self) )
    #  self.send("setting_#{__method__}", type)
    #end
    [
      :type_is_notype?,
      :type_is_num?,
      :type_is_int?,
      :type_is_str?,
      :type_is_set?,
    ].each do |_meth|
      call_name = "setting_#{_meth}"
      define_method(_meth){|name, _self: self.itself, type: nil|
        raise "Strange item name: #{name}" unless name.is_a?(String)

        type = self.type_of(name, _self: _self) if type.nil?
        FFS.send(call_name, type)
      }
    end


    ### hints.

    def hints_of( name, _self: self.itself )
      ret = FFS.settings_get_hints(name, settings: _self)
      ret
    end
    alias hints hints_of

    [
      :hints_is_bounded_above?,
      :hints_is_bounded_below?,
      :hints_is_optionlist?,
      :hints_is_toggled?,
    ].each do |_meth|
      call_name = "setting_#{_meth}"
      define_method(_meth){|name, _self: self.itself, hints: nil|
        raise "Strange item name: #{name}" unless name.is_a?(String)

        hints = self.hints_of(name, _self: _self) if hints.nil?
        FFS.send(call_name, hints)
      }
    end



  end
end


#
#
#
module FiddleFluidSynth::Interface
  module Settings

    #
    # ==== Warning
    # we have to prepare audio driver, midi driver, and synth, etc. to
    # use this method. See API Reference `fluid_settings_is_realtime()`
    #
    def is_realtime?( name, _self: self.itself )
      tmp = FFS.settings_is_realtime(_self, name: name)
      ret = (tmp != 0)
      ret
    end

  end
end


#### endof filename: util/interface/settings.rb
