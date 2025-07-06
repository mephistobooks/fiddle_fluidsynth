#
# filename: fiddle-fluidstynth/types/types.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Type declarations.
  # ==== References
  # - API References, [Types](https://www.fluidsynth.org/api/group__Types.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # these typealias-es are just for readability.
    #
    #

    #
    #
    #
    typealias 'size_t', 'unsigned int'



    # Audio driver instance.
    typealias 'fluid_audio_driver_t', 'void'

    # Shell Command Handler.
    typealias 'fluid_cmd_handler_t', 'void'

    # Command handler hash table.
    typealias 'fluid_cmd_hash_t', 'void'

    # Sequencer event.
    typealias 'fluid_event_t', 'void'

    # Callback struct to perform custom file loading of soundfonts.
    typealias 'fluid_file_callbacks_t', 'void'

    # Audio file renderer instance.
    typealias 'fluid_file_renderer_t', 'void'

    # Input stream descriptor.
    typealias 'fluid_istream_t', 'int'

    # LADSPA effects instance.
    typealias 'fluid_ladspa_fx_t', 'void'

    # A typedef for C99's type long long, which is at least 64-bit wide,
    # as guaranteed by the C99.
    typealias 'fluid_long_long_t', 'long long'

    # MIDI driver instance.
    typealias 'fluid_midi_driver_t', 'void'

    # MIDI event.
    typealias 'fluid_midi_event_t', 'void'

    # MIDI router rule.
    typealias 'fluid_midi_router_rule_t', 'void'

    # MIDI router instance.
    typealias 'fluid_midi_router_t', 'void'

    # SoundFont modulator.
    typealias 'fluid_mod_t', 'void'

    # Output stream descriptor.
    typealias  'fluid_ostream_t', 'int'

    # MIDI player instance.
    typealias 'fluid_player_t', 'void'

    # SoundFont preset.
    typealias 'fluid_preset_t', 'void'

    # SoundFont sample.
    typealias 'fluid_sample_t', 'void'

    # Unique client IDs used by the sequencer and fluid_event_t, obtained
    # by fluid_sequencer_register_client() and
    # fluid_sequencer_register_fluidsynth()
    typealias 'fluid_seq_id_t', 'short'

    # Sequencer instance.
    typealias 'fluid_sequencer_t', 'void'

    # TCP/IP shell server instance.
    typealias 'fluid_server_t', 'void'

    # Configuration settings instance.
    typealias 'fluid_settings_t', 'void'

    # SoundFont loader plugin.
    typealias 'fluid_sfloader_t', 'void'

    # SoundFont.
    typealias 'fluid_sfont_t', 'void'

    # Command shell.
    typealias 'fluid_shell_t', 'void'

    # Synthesizer instance.
    typealias 'fluid_synth_t', 'void'

    # Synthesis voice instance.
    typealias 'fluid_voice_t', 'void'


  end
end


#
#
#
class FiddleFluidSynth

  # typedefs are declaration only in header file. So we must NOT define here...
  # nothing to do.

end


#### endof filename: fiddle-fluidstynth/types/types.rb
