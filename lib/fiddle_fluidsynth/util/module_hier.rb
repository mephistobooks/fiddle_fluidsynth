#
# filename: fiddle-fluidsynth/util/module_hier.rb
#


#
#
#
class FiddleFluidSynth

  #
  class ModuleBase
    #
    class AudioOutput < ModuleBase; end
    class CommandInterface < ModuleBase; end
    class Logging     < ModuleBase; end

    class Settings    < ModuleBase; end
    class Synthesizer < ModuleBase; end

    class SoundFont   < ModuleBase; end

  end

  #
  module SoundFont_IF
    def id
    end
  end

end


#
#
#
class FiddleFluidSynth

  #
  # should be called from FiddleFluidSynth#initialize()
  #
  def init_objects( top = self )
    #
    @object = ModuleBase.new(
               parent: top, fluidsynth_instance: top, value: nil)

  end
  attr_reader :object

end


#
#
#
class FiddleFluidSynth

  #
  class ModuleBase
    def initialize( parent: , fluidsynth_instance: , value: , sub_new_f: true )
      @parent = parent
      @value  = value
      @fluidsynth_instance = fluidsynth_instance

      #
      if sub_new_f
        self.init_sub
      end

    end
    attr_reader   :parent
    attr_accessor :value
    #ng. alias :itself :value  # ng... i dont know why...
    alias :itself :value
    #def itself; self.value; end  # ok.
    # alias :object :value
    alias :obj    :value
    attr_reader   :fluidsynth_instance

    def init_sub
      @settings = Settings.new(
                    parent: self,
                    fluidsynth_instance: fluidsynth_instance, value: nil)
      #@audio_output     = AudioOutput.new(parent: self, fluidsynth_instance: fluidsynth_instance, value: nil)
      #@commandInterface = CommandInterface.new(parent: self, fluidsynth_instance: fluidsynth_instance, value: nil)
      #@logging          = Logging.new(parent: self, fluidsynth_instance: fluidsynth_instance, value: nil)
      @soundfont = SoundFont.new(
                     parent: self,
                     fluidsynth_instance: fluidsynth_instance,
                     value: fluidsynth_instance.sfonts.first)
    end
    attr_reader :settings

    #
    def soundfont( at_sfid = 1 )
      @soundfont.sfid = at_sfid
      @soundfont
    end

  end

end

#
#
#
class FiddleFluidSynth::ModuleBase

  class Settings
    def initialize( parent: , fluidsynth_instance: , value: , sub_new_f: true )
      # super
      super(parent: parent, fluidsynth_instance: fluidsynth_instance,
            value: fluidsynth_instance.settings, sub_new_f: false)

      if sub_new_f
        self.init_sub
      end

    end
    def value; self.fluidsynth_instance.settings; end
    def init_sub
    end
  end

end

#
#
#
class FiddleFluidSynth::ModuleBase

  class Synthesizer
    def initialize( parent: , fluidsynth_instance: , value: , sub_new_f: true )
      super(parent: parent, fluidsynth_instance: fluidsynth_instance,
            value: fluidsynth_instance.synth, sub_new_f: false)

      if sub_new_f
        self.init_sub
      end

    end
    def value; self.fluidsynth_instance.synth; end
    def init_sub
    end
  end

end


# SoundFont
#
#
class FiddleFluidSynth::ModuleBase
  #
  class SoundFont
    class Bank < SoundFont; end
    class Bank::Presets < Bank; end
  end

  # SoundFont.
  # this hierachy represents an array of SoundFonts.
  #
  class SoundFont

    #
    #
    # ==== Args
    # value:: NOT used.
    #
    def initialize( parent: , fluidsynth_instance: , value: nil, sub_new_f: true )
      #_val = parent.sfonts[@sfid-1]
      super(parent: parent, fluidsynth_instance: fluidsynth_instance,
            value: value, sub_new_f: false)

      #
      unless value.nil?
        @sfid = fluidsynth_instance.sfont_get_id(value)
      else
        @sfid = nil
      end
      @map_preset = {
        sfid: {
          bknum: {
            prenum: { },
          },
        },
      }

      #
      if sub_new_f
        self.init_sub
      end

    end
    attr_accessor :sfid
    attr_reader   :map_preset

    # def value( _sfid = self.sfid )
    def value( debug_f: false )
      _sfid = self.sfid
      # ret = self.fluidsynth_instance.sfonts[_sfid-1]
      # ret = self.fluidsynth_instance.synth_get_sfont_by_id(_sfid)
      idx = self.fluidsynth_instance.sfid_ary.index(_sfid)
      ret = self.fluidsynth_instance.sfonts[idx]
      $stderr.puts "{#{self.class}##{__method__}} _sfid: #{_sfid}," +
        " 0x#{ret.to_i.to_s(16)}:#{ret.class}" if debug_f
      ret
    end

    def count
      ret = self.fluidsynth_instance.synth_sfcount()
      ret
    end

    #
    #
    #
    def init_sub
      @bank = Bank.new(
                parent: self, fluidsynth_instance: fluidsynth_instance,
                value: nil, sub_new_f: true)
    end
    def bank( at_bknum = 0)
      # @bank.bank = at_bknum
      @bank.bknum = at_bknum
      @bank
    end

    #
    def full_path
      parent.soundfont_fullpath
    end

    def load( filename: self.full_path, reset_presets: parent.reset_presets,
              synth: self.fluidsynth_instance.synth )
      self.fluidsynth_instance.synth_sfload(
        filename: filename, reset_presets: reset_presets, synth: synth)
    end

    #
    def name( sfont = self.value )
      # name  = self.fluidsynth_instance.sfont_get_name(sfont).to_s
      name  = self.fluidsynth_instance.sfont_get_name(sfont)
      ret   = name
      ret
    end

    #
    #
    #
    def preset_iter_reset( _sfont = self.value )
      self.fluidsynth_instance.sfont_iteration_start(_sfont)
    end

    #
    #
    # ====
    # &blk:: {|preset| }
    #
    # ==== See Also
    # - fluidsynth_settings_foreach()
    #
    def preset_iter( debug_f: false, &blk )
      sfont = self.value
      cnt = 0
      self.preset_iter_reset(sfont)
      preset = self.fluidsynth_instance.sfont_iteration_next(sfont)
      cnt += 1

      #ng. while !(preset&.null?)
      while !(preset.nil? || preset.null?)
        $stderr.puts "cnt: #{cnt}: #{preset.inspect}" if debug_f
        blk.call(preset)

        preset = self.fluidsynth_instance.sfont_iteration_next(sfont)
        cnt += 1
      end

      cnt
    end
    alias each_preset preset_iter

    def scan_presets
      _sfnm = self.name
      @map_preset[_sfnm] = {}

      #
      ret = self.each_preset{|preset|
        bknum   = self.fluidsynth_instance.preset_get_banknum(preset)
        prenum  = self.fluidsynth_instance.preset_get_num(preset)
        prename = self.fluidsynth_instance.preset_get_name(preset)

        @map_preset[_sfnm][bknum] ||= {}
        @map_preset[_sfnm][bknum][prenum] = prename
      }

      ret
    end

  end
end


#
#
#
class FiddleFluidSynth::ModuleBase::SoundFont

  #
  class Bank
    def initialize( parent: , fluidsynth_instance: , value: , sub_new_f: true )
      super(parent: parent, fluidsynth_instance: fluidsynth_instance,
            value: fluidsynth_instance.synth, sub_new_f: false)

      if sub_new_f
        self.init_sub
      end

    end
    attr_accessor :bknum
    def value
      # TODO: 
    end
    def init_sub
      @presets = Bank::Presets.new(
        parent: self, fluidsynth_instance: fluidsynth_instance,
        value: nil, sub_new_f: true)
    end
    def presets( prenum = @presets.num )
      @presets.num = prenum
      @presets
    end

  end
end


#
#
#
class FiddleFluidSynth::ModuleBase::SoundFont::Bank

  #
  class Presets
    def initialize( parent: , fluidsynth_instance: , value: , sub_new_f: true )
      super(parent: parent, fluidsynth_instance: fluidsynth_instance,
            value: fluidsynth_instance.synth, sub_new_f: false)

      #
      @num = nil

      #
      if sub_new_f
        self.init_sub
      end

    end
    attr_accessor :num

    def value
      bknum = self.parent.bknum
      prenum = self.num
      sfont  = self.parent.parent.value

      ret = self.fluidsynth_instance.
              sfont_get_preset(sfont: sfont, bknum: bknum, prenum: prenum)
      ret
    end
    def init_sub
      # nothing todo.
    end

    # .
    def name
      preset_obj = self.value

      _name = self.fluidsynth_instance.preset_get_name(preset_obj).to_s

      ret = _name
      ret
    end

    def bknum
      preset_obj = self.value

      _bknum  = self.fluidsynth_instance.preset_get_banknum(preset_obj)
      ret = _bknum
      ret
    end

    def pre_num
      preset_obj = self.value

      _num  = self.fluidsynth_instance.preset_get_num(preset_obj)
      ret = _num
      ret
    end

  end
end


#### endof filename: fiddle-fluidsynth/util/module_hier.rb
