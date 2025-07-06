#
# filename: fiddle-fluidsynth/midi_input/player.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Parse standard MIDI files and emit MIDI events.
  # ==== References
  # - MIDI Input/[MIDI File Player](https://www.fluidsynth.org/api/group__midi__player.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  # [](https://www.fluidsynth.org/api/group__midi__player.html#gac792e9405fca53c296f7cef4d5fadfde)
  #
  enum(
    :fluid_player_set_tempo_type,
    FLUID_PLAYER_TEMPO_INTERNAL:      nil,
    FLUID_PLAYER_TEMPO_EXTERNAL_BPM:  nil,
    FLUID_PLAYER_TEMPO_EXTERNAL_MIDI: nil,
    FLUID_PLAYER_TEMPO_NBR:           nil,
  )

  #
  # - [](https://www.fluidsynth.org/api/group__midi__player.html#ga5ec93766f61465dedbbac9bdb76ced83)
  #
  enum(
    :fluid_player_status,
    FLUID_PLAYER_READY:    nil,
    FLUID_PLAYER_PLAYING:  nil,
    FLUID_PLAYER_STOPPING: nil,
    FLUID_PLAYER_DONE:     nil,
  )

  #
  module C


    # Lifecycle Functions.
    #
    #

    # Create a new MIDI player.
    extern 'fluid_player_t* new_fluid_player(fluid_synth_t*)'

    # Delete a MIDI player instance.
    extern 'void delete_fluid_player(fluid_player_t*)'


    # Functions.
    #
    #

    # Add a MIDI file to a player queue.
    # extern 'int fluid_player_add(void* player, const char*)' # also ok.
    extern 'int fluid_player_add(fluid_player_t*, char*)'

    # Add a MIDI file to a player queue, from a buffer in memory.
    extern 'int fluid_player_add_mem(fluid_player_t*, void*, size_t)'

    # Get the tempo currently used by a MIDI player.
    extern 'int fluid_player_get_bpm(fluid_player_t*)'

    # Get the number of tempo ticks passed.
    extern 'int fluid_player_get_current_tick(fluid_player_t*)'

    # Get the division currently used by a MIDI player.
    extern 'int fluid_player_get_division(fluid_player_t*)'

    # Get the tempo currently used by a MIDI player.
    extern 'int fluid_player_get_midi_tempo(fluid_player_t*)'

    # Get MIDI player status.
    extern 'int fluid_player_get_status(fluid_player_t*)'

    # Looks through all available MIDI tracks and gets the absolute tick
    # of the very last event to play.
    extern 'int fluid_player_get_total_ticks(fluid_player_t*)'

    # Wait for a MIDI player until the playback has been stopped.
    extern 'int fluid_player_join(fluid_player_t*)'

    # Activates play mode for a MIDI player if not already playing.
    extern 'int fluid_player_play(fluid_player_t*)'

    # Seek in the currently playing file.
    extern 'int fluid_player_seek(fluid_player_t*, int)'

    ### setters.

    # Set the tempo of a MIDI player in beats per minute.
    extern 'int fluid_player_set_bpm(fluid_player_t*, int)'

    # Enable looping of a MIDI player.
    extern 'int fluid_player_set_loop(fluid_player_t*, int)'

    # Set the tempo of a MIDI player.
    extern 'int fluid_player_set_midi_tempo(fluid_player_t*, int)'

    # Change the MIDI callback function.
    extern 'int fluid_player_set_playback_callback' +
      '(fluid_player_t*, handle_midi_event_func_t, void*)'

    # Set the tempo of a MIDI player.
    extern 'int fluid_player_set_tempo(fluid_player_t*, int, double)'

    # Add a listener function for every MIDI tick change.
    extern 'int fluid_player_set_tick_callback' +
      '(fluid_player_t*, handle_midi_tick_func_t, void*)'
      # '(fluid_player_t*, void*, void*)'

    # Pauses the MIDI playback.
    extern 'int fluid_player_stop(fluid_player_t*)'

  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  def self.player_new( synth )
    ret = C.new_fluid_player(synth)
    ret
  end
  def player_new( synth = self.synth )
    self.class.player_new(synth)
  end

  def self.player_delete( player )
    ret = C.delete_fluid_player(player)
    ret
  end
  def player_delete( player = self.player )
    self.class.player_delete(player)
  end

end


#
#
#
class FiddleFluidSynth

  # def player_add( file: , player: self.player )
  def player_add( player = self.player, file: )
    ret = C.fluid_player_add(player, file)
    ret
  end

  def player_add_mem( player = self.player, buf: , size: )
    ret = C.fluid_player_add_mem(player, buf, size)
    ret
  end

  #
  def player_get_bpm( player = self.player )
    ret = C.fluid_player_get_bpm(player)
    ret
  end
  alias :player_bpm :player_get_bpm

  def player_get_current_tick( player = self.player )
    ret = C.fluid_player_get_current_tick(player)
    ret
  end

  def player_get_division( player = self.player )
    ret = C.fluid_player_get_division(player)
    ret
  end

  def player_get_midi_tempo( player = self.player )
    ret = C.fluid_player_get_midi_tempo(player)
    ret
  end

  def player_get_status( player = self.player )
    ret = C.fluid_player_get_status(player)
    ret
  end
  alias :player_status :player_get_status

  def player_get_total_ticks( player = self.player )
    ret = C.fluid_player_get_total_ticks(player)
    ret
  end

  def player_join( player = self.player )
    ret = C.fluid_player_join(player)
    ret
  end

  def player_play( player = self.player )
    ret = C.fluid_player_play(player)
    ret
  end

  #
  def player_seek( player = self.player, ticks: )
    ret = C.fluid_player_seek(player, ticks)
    ret
  end

  ### .

  #
  def player_set_bpm( player = self.player, bpm: )
    deprecated_msg_instead('player_set_tempo()', meth: __method__)
    ret = C.fluid_player_set_bmp(player, bpm)
    ret
  end

  #
  # ==== Args
  # times:: Times left to loop the playlist. -1 means loop infinitely.
  #
  def player_set_loop( player = self.player, times: )
    ret = C.fluid_player_set_loop(player, times)
    ret
  end

  def player_set_midi_tempo( player = self.player, tempo: )
    deprecated_msg_instead('player_set_tempo()', meth: __method__)
    ret = C.fluid_player_set_midi_tempo(player, tempo)
    ret
  end

  def player_set_playback_callback( player=self.player,
                                    handler: , handler_data: )
    ret = C.fluid_player_set_playback_callback(player, handler, handler_data)
    ret
  end

  def player_set_tempo( player=self.player, tempo: )
    ret = C.fluid_player_set_tempo(player, tempo)
    ret
  end

  #
  # ==== Args
  # handler:: callback function address (in Fiddle::Pointer(FFI::Pointer)).
  # handler_data:: Fiddle::Pointer.new(FFI::Pointer#address).
  #   (actually this arg is
  #   meaningless in Ruby. because we can use closure to describe
  #   callback function.)
  # yeild::
  #   {|user_data, cur_tick| ... } is tick callback function, where
  #   cur_tick is current tick in MIDI file.
  #
  # ==== See Also
  # - util/util.rb:define_tick_callback().
  #
  def player_set_tick_callback( player=self.player,
                                handler: nil, handler_data: nil )
    #
    if handler.nil? && block_given?
      cb_ptr = self.define_tick_callback(){|user_data, cur_tick|
        yield(user_data, cur_tick)
      }
      handler = cb_ptr
    elsif !(handler.nil?)
      # do nothing.
    else
      raise "Specify the handler in args or block."
    end

    #
    ret = C.fluid_player_set_tick_callback(player, handler, handler_data)
    ret
  end

  def player_stop( player = self.player )
    ret = C.fluid_player_stop(player)
    ret
  end


end


#### endof filename: fiddle-fluidsynth/midi_input/player.rb
