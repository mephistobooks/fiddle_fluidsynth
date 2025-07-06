#
# filename: fiddle-fluidsynth/util/util.rb
#

#
require 'fiddle/import'
require 'rbconfig'


#
#
#
class FiddleFluidSynth
  #
  SOUNDFONT_NAME_DEFAULT = "default.sf2"

  #
  module C

    #
    #
    #
    def self.current_platform
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /darwin/  then :macos
      when /linux/   then :linux
      when /mswin|mingw|cygwin/ then :windows
      else raise "Unsupported OS: #{host_os}"
      end
    end

    def self.lib_path( name )
      case current_platform
      when :macos
        brew_prefix = `brew --prefix`.strip
        path = File.exist?("#{brew_prefix}/lib/lib#{name}.dylib") ? \
          "#{brew_prefix}/lib" : "/usr/local/lib"
        # File.join(path, "lib#{name}.dylib")
        path
      when :linux
        path = `pkg-config --libs-only-L #{name} 2>/dev/null`.sub("-L", "").strip
        raise "pkg-config couldn't find #{name}" if path.empty?
        # File.join(path, "lib#{name}.so")
        path
      when :windows
        # DLLは PATH に通ってるか、明示パスで指定
        path = ENV["LIB_FLUIDSYNTH_PATH"] || "#{name}.dll"
        raise "Set LIB_FLUIDSYNTH_PATH env var or place " +
          "#{name}.dll in working dir" unless File.exist?(path)
        path
      end
    end

    def self.full_path_for_lib( name )
      lib_path = lib_path(name)

      case current_platform
      when :macos
        File.join(lib_path, "lib#{name}.dylib")
      when :linux
        File.join(lib_path, "lib#{name}.so")
      when :windows
        # DLLは PATH に通ってるか、明示パスで指定
        File.join(lib_path, "#{name}.dll")
      end
    end

    #
    #
    #
    def self.soundfont_path
      case current_platform
      when :macos
        brew_prefix = `brew --prefix`.strip
        share_dir = File.exist?("#{brew_prefix}/share/fluid-synth/sf2") ? \
          "#{brew_prefix}/share/fluid-synth/sf2" : \
          "/usr/local/share/fluid-synth/sf2"

        share_dir
      when :linux
        name = "fluidsynth"
        path = `pkg-config --libs-only-L #{name} 2>/dev/null`.sub("-L", "").strip
        raise "pkg-config couldn't find #{name}" if path.empty?
        path = path + "/../share/fluid-synth/sf2"

        path
      when :windows
        # DLLは PATH に通ってるか、明示パスで指定
        path = ENV["SOUNDFONT_PATH"] || "#{name}.dll"
        raise "Set LIB_FLUIDSYNTH_PATH env var or place " +
          "#{name}.dll in working dir" unless File.exist?(path)
        path
      end
    end

    def self.full_path_for_soundfont( sf2_filename = SOUNDFONT_NAME_DEFAULT )
      self.soundfont_path + "/" + sf2_filename
    end

    #
    # begin
    #   lib_fluidsynth = self.lib_path_for('fluidsynth')
    #   dlload lib_fluidsynth
    # rescue
    #   raise LoadError, "Couldn't find the fluidsynth library."
    # end

  end

  #
  def self.obtain_soundfont_path
    C.soundfont_path
  end
  def obtain_soundfont_path
    self.class.obtain_soundfont_path
  end

  def self.obtain_full_path_for_soundfont( sf2_filename = SOUNDFONT_NAME_DEFAULT )
    C.full_path_for_soundfont(sf2_filename)
  end
  def obtain_full_path_for_soundfont( sf2_filename = SOUNDFONT_NAME_DEFAULT )
    self.class.obtain_full_path_for_soundfont(sf2_filename)
  end

end


#
# ==== References
# https://www.fluidsynth.org/api/deprecated.html
#
class FiddleFluidSynth

  URI_DEPRECATED = "https://www.fluidsynth.org/api/deprecated.html"

  #
  def self.deprecated_msg( meth )
    $stderr.puts "(**) #{meth} is deprecated. See #{URI_DEPRECATED}"
  end
  def deprecated_msg( meth )
    self.class.deprecated_msg(meth)
  end

  #
  def self.deprecated_msg_instead( instead, meth: )
    $stderr.puts "(**) #{meth} is deprecated. Use #{instead} instead."
  end
  def deprecated_msg_instead( instead, meth: )
    self.class.deprecated_msg_instead(instead, meth: meth)
  end


end


#
#
#
class FiddleFluidSynth

  #
  BANK_NUM_MIN =     0
  BANK_NUM_MAX = 16383
  BKNUM_RANGE_WHOLE = BANK_NUM_MIN..BANK_NUM_MAX

  PROG_NUM_MIN =   0
  PROG_NUM_MAX = 127
  PGNUM_RANGE_WHOLE = PROG_NUM_MIN..PROG_NUM_MAX

  #
  CHAN_NUM_MIN =   0
  # CHAN_NUM_MAX = # MIDI channel count -1

  KEY_NUM_MIN =   0
  KEY_NUM_MAX = 127
  KEY_RANGE_WHOLE = KEY_NUM_MIN..KEY_NUM_MAX

  VEL_NUM_MIN =   0
  VEL_NUM_MAX = 127
  VEL_RANGE_WHOLE = VEL_NUM_MIN..VEL_NUM_MAX

  #
  def self.bknum_range_whole;  BKNUM_RANGE_WHOLE; end
  def self.pgnum_range_whole;  PGNUM_RANGE_WHOLE; end
  def self.key_range_whole;   KEY_RANGE_WHOLE;   end
  def self.velc_range_whole;  VEL_RANGE_WHOLE;   end
  class <<self
    alias bank_range_whole  bknum_range_whole
    alias prog_range_whole  pgnum_range_whole
    alias vel_range_whole   velc_range_whole
  end

  # for instance methods.
  [:bknum_range_whole, :bank_range_whole,
   :pgnum_range_whole, :prog_range_whole,
   :key_range_whole,
   :velc_range_whole,].each do |meth|
     define_method(meth){ self.class.send(meth) }
  end
  alias vel_range_whole velc_range_whole

end


#
#
#
class FiddleFluidSynth

  #
  AUDIO_DRIVER_LIST = [
    'alsa', 'oss', 'jack', 'portaudio', 'sndmgr', 'coreaudio',
    'Direct Sound']

  #
  def audio_driver_prepare( driver = nil,
                            settings: self.settings, synth: self.synth,
                            new2_f: false, cb_ptr: nil )

    #
    if self.audio_driver && !(self.audio_driver.null?)
      $stderr.puts "(**) audio driver has already been set." +
        " currently multiple drivers setting is NOT supported." +
        " So #{__method__} ignore this call..."
    else

      ### set the driver name into the settings if it is given.
      if !(driver.to_s == "")
        raise "NOT supported driver: #{driver}." +
          " Choose one of #{AUDIO_DRIVER_LIST}" unless \
          AUDIO_DRIVER_LIST.include?(driver)

        #
        self.settings.audio_driver = driver
      end

      ### create audio driver instance.
      @audio_driver = if !(new2_f) && cb_ptr.nil?
                        self.audio_driver_new(
                          settings: settings, synth: synth)
                      elsif new2_f || cb_ptr
                        self.audio_driver_new2(
                          settings: settings, audio_func: cb_ptr)
                      else
                        raise "(**) Failed to prepare the audio driver."
                      end

      if @audio_driver.nil? || @audio_driver.null?
        raise "(**) Failed to create the audio driver."
      end
      $stderr.puts "(**) Audio driver is set" +
        " (0x#{@audio_driver.to_i.to_s(16)}:#{@audio_driver.class})."

    end
    @audio_driver
  end

  #
  def start( driver = nil )
    self.audio_driver_prepare(driver)
  end

end


# Settings.
#
#
class FiddleFluidSynth

  #
  def self.settings_item_to_meth_name( item )
    Interface::Settings.item_to_meth_name(item)
  end

  # #settings_get_type().
  #
  #
  def self.setting_type_is_notype?( type )
    type == FiddleFluidSynth::Enum_fluid_types_enum::FLUID_NO_TYPE
  end

  def self.setting_type_is_num?( type )
    type == FiddleFluidSynth::Enum_fluid_types_enum::FLUID_NUM_TYPE
  end

  def self.setting_type_is_int?( type )
    type == FiddleFluidSynth::Enum_fluid_types_enum::FLUID_INT_TYPE
  end

  def self.setting_type_is_str?( type )
    type == FiddleFluidSynth::Enum_fluid_types_enum::FLUID_STR_TYPE
  end

  def self.setting_type_is_set?( type )
    type == FiddleFluidSynth::Enum_fluid_types_enum::FLUID_SET_TYPE
  end
  [
    :setting_type_is_notype?,
    :setting_type_is_num?,
    :setting_type_is_int?,
    :setting_type_is_str?,
    :setting_type_is_set?,
  ].each do |_meth|
    define_method(_meth){|type| self.class.send(__method__, type) }
  end


  # settings_get_hints().
  #
  #
  def self.setting_hints_is_bounded_above?( hints )
    ret = hints & FLUID_HINT_BOUNDED_ABOVE
    ret != 0
  end
  def self.setting_hints_is_bounded_below?( hints )
    ret = hints & FLUID_HINT_BOUNDED_BELOW
    ret != 0
  end
  def self.setting_hints_is_optionlist?( hints )
    ret = hints & FLUID_HINT_OPTIONLIST
    ret != 0
  end
  def self.setting_hints_is_toggled?( hints )
    ret = hints & FLUID_HINT_TOGGLED
    ret != 0
  end
  [
    :setting_hints_is_bounded_above?,
    :setting_hints_is_bounded_below?,
    :setting_hints_is_optionlist?,
    :setting_hints_is_toggled?,
  ].each do |_meth|
    define_method(_meth){|hints| self.class.send(__method__, hints) }
  end

end


# SoundFont.
#
#
class FiddleFluidSynth
  def sfonts( synth = self.synth )
    ret = self.sfid_ary.map{|_sfid|
      self.synth_get_sfont_by_id(synth, id: _sfid)
    }
    ret
  end
  def sfont
    ret = self.sfonts.first
    $stderr.puts "{#{__method__}} ret: #{ret.class}"
    ret
  end
end


#
#
#
class FiddleFluidSynth

  # from: synth/midi/message.rb
  #
  #

  #
  def noteon( ch, key, vel, synth = self.synth )
    self.synth_noteon(synth, ch: ch, key: key, vel: vel)
  end

  def noteoff( ch, key, synth = self.synth )
    self.synth_noteoff(synth, ch: ch, key: key)
  end

  def pitch_bend( ch, val, synth = self.synth )
    # C.fluid_synth_pitch_bend(@synth, ch, val + 8192)
    self.synth_pitch_bend(synth, ch: ch, val: val)
  end

  # control change.
  def control_change( ch, ctrlnum, val, synth = self.synth )
    self.synth_cc(synth, ch: ch, num: ctrlnum, val: val)
  end
  alias cc control_change

  ### program.

  # TODO. remove?
  def program_select( ch: ,
                      bknum: , prenum: , sfid: self.sfid_latest,
                      synth: self.synth )
    self.synth_program_select(synth, ch: ch,
      sfid: sfid, bknum: bknum, prenum: prenum)
  end

  def program_change( ch, pgnum, synth = self.synth )
    # C.fluid_synth_program_change(synth, ch, pgnum)
    self.synth_program_change(synth, ch: ch, pgnum: pgnum)
  end

  def program_reset( synth = self.synth )
    # C.fluid_synth_program_reset(synth)
    self.synth_program_reset(synth)
  end

  #
  def sfont_select( ch, sfid, synth = self.synth )
    # C.fluid_synth_sfont_select(synth, ch, sfid)
    self.synth_sfont_select(synth, ch: ch, sfid: sfid)
  end

  def bank_select( ch, bknum, synth = self.synth )
    # C.fluid_synth_bank_select(synth, ch, bknum)
    self.synth_bank_select(synth, ch: ch, bknum: bknum)
  end

  # synth/midi/message.rb
  #
  #
  def system_reset( synth = self.synth )
    # C.fluid_synth_system_reset(synth)
    self.synth_system_reset(synth)
  end

  # midi_input/player.rb
  #
  # TODO. args. player=self.player, file: file)
  # def player_file( file, player: self.player )
  def player_file( file, player: self.player )
    self.player_add(player, file: file)
    self.player_play(player)
  end
  alias play_file player_file


  # in midi_input/player.rb
  #
  # def player_status( player = self.player )
  #   ret = C.fluid_player_get_status(player)
  #   ret
  # end

  #
  def __player_is_done?( player: , status: )
    tmp = self.player_status(player)
    ret = (tmp == status)
    ret
  end
  def player_is_ready?( player = self.player )
    self.__player_is_done?(player: player, status: FLUID_PLAYER_READY)
  end
  def player_is_playing?( player = self.player )
    self.__player_is_done?(player: player, status: FLUID_PLAYER_PLAYING)
  end
  def player_is_stopping?( player = self.player )
    self.__player_is_done?(player: player, status: FLUID_PLAYER_STOPPING)
  end
  def player_is_done?( player = self.player )
    self.__player_is_done?(player: player, status: FLUID_PLAYER_DONE)
  end

end


#### endof filename: fiddle-fluidsynth/util/util.rb
