#
# filename: fiddle_fluidsynth/fiddle_fluidsynth.rb
#

#
require 'fiddle/import'
require 'rbconfig'


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth
  module C
    #
    begin
      lib_fluidsynth = self.full_path_for_lib('fluidsynth')
      dlload lib_fluidsynth
    rescue
      raise LoadError, "Couldn't find the fluidsynth library."
    end

  end

end


#
#
# ==== References
# - [Settings Reference](https://www.fluidsynth.org/api/fluidsettings.html)
#
#
class FiddleFluidSynth

  #
  #
  # ==== Args
  # soundfont_name:: SoundFont file name. do NOT load when nil.
  # reset_presets:: true then presets are updated immediately.
  #
  def initialize( soundfont_name: SOUNDFONT_NAME_DEFAULT,
                  soundfont_path: self.obtain_soundfont_path,
                  soundfont_full_path:
                    "#{soundfont_path}/#{soundfont_name}",
                  # gain:          0.2,
                  # samplerate:    44100.0,
                  # midi_channels: 256,
                  gain:          nil,
                  samplerate:    nil,
                  midi_channels: nil,
                  player_f:       true,
                  audio_driver_f: true,
                  audio_driver_name: nil,
                  audio_driver_new2_f:   false,
                  audio_driver_callback: nil,
                  reset_presets: true )

    ### prepare Settings.
    @settings = self.settings_new
    if self.settings.null?
      $stderr.puts "(**) Failed to create settings."
      self.delete
      exit
    end

    # TODO. in args.?
    #
    #
    # self.settings_setnum(name: 'synth.gain',          val: gain)
    # self.settings_setnum(name: 'synth.sample-rate',   val: samplerate)
    # self.settings_setint(name: 'synth.midi-channels', val: midi_channels)
    self.settings.
      synth_gain           = gain           unless gain.nil?
    self.settings.
      synth_sample__rate   = samplerate     unless samplerate.nil?
    self.settings.
      synth_midi__channels = midi_channels  unless midi_channels.nil?

    ### prepare Synthesizer.
    @synth  = self.synth_new(self.settings)
    if self.synth.null?
      $stderr.puts "(**) Failed to create synthesizer."
      self.delete
      exit
    end

    ### prepare SoundFont.
    @soundfont_full_path = soundfont_full_path
    @reset_presets       = reset_presets
    @sfid_ary = []      # set in sfont_sfload().
    @sfid_latest = nil

    #
    unless soundfont_name.to_s == ""
      tmp = self.synth_sfload(synth, filename: @soundfont_full_path,
                              reset_presets: @reset_presets,
                              verbose_f: true)
      if FLUID_FAILED == tmp
        $stderr.puts "(**) Failed to load the SoundFont."
        self.delete
        exit
      end
    else
      $stderr.puts "(**) SoundFont has NOT been loaded in the initializer."
    end

    ### prepare Player.
    @player = nil
    if player_f
      @player = self.player_new(self.synth)
      if self.player.null?
        $stderr.puts "(**) Failed to create player."
        self.delete
        exit
      end
    end

    ### prepare Audio Driver.
    @audio_driver = nil
    # self.audio_driver_prepare(
    #   audio_driver_name, settings: self.settings, synth: self.synth,
    #   new2_f: audio_driver_new2_f
    # )
    # if self.audio_driver.null?
    #   $stderr.puts "(**) Failed to prepare audio driver."
    #   self.delete
    #   exit
    # end
    if audio_driver_f
      self.audio_driver_prepare(
        audio_driver_name,
        settings: self.settings, synth: self.synth,
        new2_f: audio_driver_new2_f, cb_ptr: audio_driver_callback)

    else
      $stderr.puts "(**) Do prepare audio driver."
    end
    @file_renderer = nil

    ### create module hierarchy.
    self.init_objects(self)

  end
  attr_reader :settings, :synth, :player
  attr_reader :audio_driver
  attr_reader :file_renderer

  attr_reader :soundfont_full_path, :reset_preset
  # attr_reader :sfid, :sfid_latest
  attr_reader :sfid_ary, :sfid_latest

end


#
#
#
class FiddleFluidSynth

  def delete
    self.audio_driver_delete(self.audio_driver) if self.audio_driver &&
                                                     !(self.audio_driver.null?)
    self.player_delete(self.player)     if self.player &&
                                             !(self.player.null?)
    self.synth_delete(self.synth)       if self.synth &&
                                             !(self.synth.null?)
    self.settings_delete(self.settings) if self.settings &&
                                             !(self.settings.null?)
  end

end


#### endof filename: fiddle_fluidsynth/iddle_fluidsynth.rb
