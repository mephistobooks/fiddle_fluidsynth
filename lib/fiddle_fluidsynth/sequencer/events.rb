#
# filename: fiddle-fluidstynth/sequencer/events.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Create, modify, query and destroy sequencer events.
  # ==== References
  # - API Reference, MIDI Sequencer/[Sequencer Events](https://www.fluidsynth.org/api/group__sequencer.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  # ==== See Also
  # - midi_input/events.rb

  # Enumerations
  #
  #

  # Sequencer event type enumeration.
  enum(
    :fluid_seq_event_type,
    FLUID_SEQ_NOTE:              0,
    FLUID_SEQ_NOTEON:          nil,
    FLUID_SEQ_NOTEOFF:         nil,
    FLUID_SEQ_ALLSOUNDSOFF:    nil,
    FLUID_SEQ_ALLNOTESOFF:     nil,
    FLUID_SEQ_BANKSELECT:      nil,
    FLUID_SEQ_PROGRAMCHANGE:   nil,
    FLUID_SEQ_PROGRAMSELECT:   nil,
    FLUID_SEQ_PITCHBEND:       nil,
    FLUID_SEQ_PITCHWHEELSENS:  nil,
    FLUID_SEQ_MODULATION:      nil,

    FLUID_SEQ_SUSTAIN:         nil,
    FLUID_SEQ_CONTROLCHANGE:   nil,
    FLUID_SEQ_PAN:             nil,
    FLUID_SEQ_VOLUME:          nil,
    FLUID_SEQ_REVERBSEND:      nil,
    FLUID_SEQ_CHORUSSEND:      nil,
    FLUID_SEQ_TIMER:           nil,
    FLUID_SEQ_CHANNELPRESSURE: nil,
    FLUID_SEQ_KEYPRESSURE:     nil,
    FLUID_SEQ_SYSTEMRESET:     nil,

    FLUID_SEQ_UNREGISTERING:   nil,
    FLUID_SEQ_SCALE:           nil,
    FLUID_SEQ_LASTEVENT:       nil)


  #
  module C

    # Lifecycle Functions (MIDI Sequencer).
    #
    #

    # Create a new sequencer event structure.
    extern 'fluid_event_t* new_fluid_event(void)'

    # Delete a sequencer event structure.
    extern 'void delete_fluid_event(fluid_event_t*)'


    # Functions.
    #
    #

    # Set a sequencer event to be a all notes off event.
    extern 'void fluid_event_all_notes_off(fluid_event_t*, int)'

    # Set a sequencer event to be an all sounds off event.
    extern 'void fluid_event_all_sounds_off(fluid_event_t*, int)'

    # Set a sequencer event to be a bank select event.
    extern 'void fluid_event_bank_select(fluid_event_t*, int, short)'

    # Set a sequencer event to be a channel-wide aftertouch event.
    extern 'void fluid_event_channel_pressure(fluid_event_t*, int, int)'

    # Set a sequencer event to be a chorus send event.
    extern 'void fluid_event_chorus_send(fluid_event_t*, int, int)'

    # Set a sequencer event to be a MIDI control change event.
    extern 'void fluid_event_control_change(fluid_event_t*, int, short, int)'

    # Transforms an incoming MIDI event (from a MIDI driver or MIDI router)
    # to a sequencer event.
    extern 'int fluid_event_from_midi_event' +
      '(fluid_event_t*, fluid_midi_event_t*)'


    ### getters.

    # Get the MIDI bank field from a sequencer event structure.
    extern 'short fluid_event_get_bank(fluid_event_t*)'

    # Get the MIDI channel field from a sequencer event structure.
    extern 'int fluid_event_get_channel(fluid_event_t*)'

    # Get the MIDI control number field from a sequencer event structure.
    extern 'short fluid_event_get_control(fluid_event_t*)'

    # Get the data field from a sequencer event structure.
    extern 'void* fluid_event_get_data(fluid_event_t*)'

    # Get the dest sequencer client from a sequencer event structure.
    extern 'fluid_seq_id_t fluid_event_get_dest(fluid_event_t*)'

    # Get the duration field from a sequencer event structure.
    extern 'unsigned int fluid_event_get_duration(fluid_event_t*)'

    # Get the MIDI note field from a sequencer event structure.
    extern 'short fluid_event_get_key(fluid_event_t*)'

    # Get the pitch field from a sequencer event structure.
    extern 'int fluid_event_get_pitch(fluid_event_t*)'

    # Get the MIDI program field from a sequencer event structure.
    extern 'int fluid_event_get_program(fluid_event_t*)'

    # Gets time scale field from a sequencer event structure.
    extern 'double fluid_event_get_scale(fluid_event_t*)'

    # Get the SoundFont ID field from a sequencer event structure.
    extern 'unsigned int fluid_event_get_sfont_id(fluid_event_t*)'

    # Get the source sequencer client from a sequencer event structure.
    extern 'fluid_seq_id_t fluid_event_get_source(fluid_event_t*)'

    # Get the event type (fluid_seq_event_type) field from a sequencer
    # event structure.
    extern 'int fluid_event_get_type(fluid_event_t*)'

    # Get the value field from a sequencer event structure.
    extern 'int fluid_event_get_value(fluid_event_t*)'

    # Get the MIDI velocity field from a sequencer event structure.
    extern 'short fluid_event_get_velocity(fluid_event_t*)'

    ### .

    # Set a sequencer event to be a polyphonic aftertouch event.
    extern 'void fluid_event_key_pressure(fluid_event_t*, int, short, int)'

    # Set a sequencer event to be a modulation event.
    extern 'void fluid_event_modulation(fluid_event_t*, int, int)'

    # Set a sequencer event to be a note duration event.
    extern 'void fluid_event_note' +
      '(fluid_event_t*, int, short, short, unsigned int)'

    # Set a sequencer event to be a note off event.
    extern 'void fluid_event_noteoff(fluid_event_t*, int, short)'

    # Set a sequencer event to be a note on event.
    extern 'void fluid_event_noteon(fluid_event_t*, int, short, short)'

    # Set a sequencer event to be a stereo pan event.
    extern 'void fluid_event_pan(fluid_event_t*, int, int)'

    # Set a sequencer event to be a pitch bend event.
    extern 'void fluid_event_pitch_bend(fluid_event_t*, int, int)'

    # Set a sequencer event to be a pitch wheel sensitivity event.
    extern 'void fluid_event_pitch_wheelsens(fluid_event_t*, int, int)'

    # Set a sequencer event to be a program change event.
    extern 'void fluid_event_program_change(fluid_event_t*, int, int)'

    # Set a sequencer event to be a program select event.
    extern 'void fluid_event_program_select' +
      '(fluid_event_t*, int, unsigned int, short, short)'

    # Set a sequencer event to be a reverb send event.
    extern 'void fluid_event_reverb_send(fluid_event_t*, int, int)'

    # Set a sequencer event to be a scale change event.
    extern 'void fluid_event_scale(fluid_event_t*, double)'

    # Set destination of this sequencer event, i.e.
    extern 'void fluid_event_set_dest(fluid_event_t*, fluid_seq_id_t)'

    # Set source of a sequencer event.
    extern 'void fluid_event_set_source(fluid_event_t*, fluid_seq_id_t)'

    # Set a sequencer event to be a MIDI sustain event.
    extern 'void fluid_event_sustain(fluid_event_t*, int, int)'

    # Set a sequencer event to be a midi system reset event.
    extern 'void fluid_event_system_reset(fluid_event_t*)'

    # Set a sequencer event to be a timer event.
    extern 'void fluid_event_timer(fluid_event_t*, void*)'

    # Set a sequencer event to be an unregistering event.
    extern 'void fluid_event_unregistering(fluid_event_t*)'

    # Set a sequencer event to be a volume event.
    extern 'void fluid_event_volume(fluid_event_t*, int, int)'

  end
end


#
#
#
class FiddleFluidSynth

  #
  module SequencerEventIF
    module EventIF; end
  end

  #
  extend SequencerEventIF
  include SequencerEventIF

end


# Lifecycle Functions (SequencerEventIF).
#
#
class FiddleFluidSynth
  module SequencerEventIF

    #
    def event_new()
      ret = C.new_fluid_event()
      ret.extend(EventIF)
      ret
    end

    def event_delete( ev )
      ret = C.delete_fluid_event(ev)
      ret
    end

    #ng. def seq_event( type, ..., &blk )
    def seq_event( type, ... )
      ev = event_new()
      ev.set_type(type, ...)

      # blk.(ev)
      yield(ev)

      event_delete(ev)
    end

  end
end


# Functions (SequencerEventIF).
#
#
class FiddleFluidSynth
  module SequencerEventIF

    ### getters.

    def event_get_bank( ev )
      ret = C.fluid_event_get_bank(ev)
      ret
    end
    alias event_get_bknum event_get_bank

    def event_get_channel( ev )
      ret = C.fluid_event_get_channel(ev)
      ret
    end

    def event_get_control( ev )
      ret = C.fluid_event_get_control(ev)
      ret
    end

    def event_get_data( ev )
      ret = C.fluid_event_get_data(ev)
      ret
    end

    def event_get_dest( ev )
      ret = C.fluid_event_get_dest(ev)
      ret
    end

    def event_get_duration( ev )
      ret = C.fluid_event_get_duration(ev)
      ret
    end

    def event_get_key( ev )
      ret = C.fluid_event_get_key(ev)
      ret
    end

    def event_get_pitch( ev )
      ret = C.fluid_event_get_pitch(ev)
      ret
    end

    def event_get_program( ev )
      ret = C.fluid_event_get_program(ev)
      ret
    end

    def event_get_scale( ev )
      ret = C.fluid_event_get_scale(ev)
      ret
    end

    def event_get_sfont_id( ev )
      ret = C.fluid_event_get_sfont_id(ev)
      ret
    end
    alias event_get_sfid event_get_sfont_id

    def event_get_source( ev )
      ret = C.fluid_event_get_source(ev)
      ret
    end
    alias event_get_src event_get_source

    def event_get_type( ev )
      ret = C.fluid_event_get_type(ev)
      ret
    end

    def event_get_value( ev )
      ret = C.fluid_event_get_value(ev)
      ret
    end

    def event_get_velocity( ev )
      ret = C.fluid_event_get_velocity(ev)
      ret
    end


    ### Type Setters.

    #
    def event_note( ev, ch: , key: , vel: , duration: )
      ret = C.fluid_event_note(ev, ch, key, vel, duration)
      ret
    end

    def event_noteon( ev, ch: , key: , vel: )
      ret = C.fluid_event_noteon(ev, ch, key, vel)
      ret
    end

    def event_noteoff( ev, ch: , key: )
      ret = C.fluid_event_noteoff(ev, ch, key)
      ret
    end

    #
    def event_all_sounds_off( ev, ch: )
      ret = C.fluid_event_all_sounds_off(ev, ch)
      ret
    end

    def event_all_notes_off( ev, ch: )
      ret = C.fluid_event_all_notes_off(ev, ch)
      ret
    end

    def event_bank_select( ev, ch: , bknum: )
      ret = C.fluid_event_bank_select(ev, ch, bknum)
      ret
    end

    # def event_program_change( ev, ch: , prenum: )
    def event_program_change( ev, ch: , pgnum: nil, prenum: nil,
                              _pgnum: pgnum||prenum)
      ret = C.fluid_event_program_change(ev, ch, _pgnum)
      ret
    end

    def event_program_select( ev, ch: , sfid: , bknum: ,
                              prenum: nil, pgnum: nil,
                              _prenum: prenum||pgnum )
      ret = C.fluid_event_program_select(ev, ch, sfid, bknum, _prenum)
      ret
    end

    # def event_pitch_bend( ev, ch: , val: )
    def event_pitch_bend( ev, ch: , pitch: nil, val: nil,
                          _pitch: pitch || val)
      ret = C.fluid_event_pitch_bend(ev, ch, _pitch)
      ret
    end

    def event_pitch_wheelsens( ev, ch: , val: )
      ret = C.fluid_event_pitch_wheelsens(ev, ch, val)
      ret
    end

    def event_modulation( ev, ch: , val: )
      ret = C.fluid_event_modulation(ev, ch, val)
      ret
    end


    #
    def event_sustain( ev, ch: , val: )
      ret = C.fluid_event_sustain(ev, ch, val)
      ret
    end

    def event_control_change( ev, ch: , ctrl: , val: )
      ret = C.fluid_event_control_change(ev, ch, ctrl, val)
      ret
    end

    def event_pan( ev, ch: , val: )
      ret = C.fluid_event_pan(ev, ch, val)
      ret
    end

    def event_volume( ev, ch: , val: )
      ret = C.fluid_event_volume(ev, ch, val)
      ret
    end

    def event_reverb_send( ev, ch: , val: )
      ret = C.fluid_event_reverb_send(ev, ch, val)
      ret
    end

    def event_chorus_send( ev, ch: , val: )
      ret = C.fluid_event_chorus_send(ev, ch, val)
      ret
    end

    def event_timer( ev, data: )
      ret = C.fluid_event_timer(ev,data)
      ret
    end

    def event_channel_pressure( ev, ch: , val: )
      ret = C.fluid_event_channel_pressure(ev, ch, val)
      ret
    end

    def event_key_pressure( ev, ch: , key: , val: )
      ret = C.fluid_event_key_pressure(ev,ch,key,val)
      ret
    end

    def event_system_reset( ev )
      ret = C.fluid_event_system_reset(ev)
      ret
    end

    #
    def event_unregistering( ev )
      ret = C.fluid_event_unregistering(ev)
      ret
    end

    def event_scale( ev, scale: )
      ret = C.fluid_event_scale(ev,scale)
      ret
    end

    # last_event.


    ### .

    #
    #
    # ==== Returns
    # FLUID_OK or FLUID_FAILED.
    #
    def event_from_midi_event( ev, midi_ev: )
      ret = C.fluid_event_from_midi_event(ev, midi_ev)
      ret
    end


    ### setters.

    def event_set_dest( ev, dest: )
      ret = C.fluid_event_set_dest(ev,dest)
      ret
    end

    def event_set_source( ev, src: )
      ret = C.fluid_event_set_source(ev,src)
      ret
    end
    alias event_set_src event_set_source


  end
end


#
#
#
class FiddleFluidSynth
  module SequencerEventIF::EventIF

    # getter only.
    #
    #

    [
      :bank,
      :channel,
      :control,
      :data,
      # :dest,
      :duration,
      :key,
      :pitch,
      :program,   # alias as pgnum, prenum.
      :scale,
      :sfont_id,  # alias sfid.
      # :source,
      :type,
      :value,     # alias as val.
      :velocity,  # alias vel, velc.
    ].each do |_meth|
      meth_name = _meth
      call_name = 'event_get_'+_meth.to_s

      define_method(meth_name){|_self = self.itself|
        FFS.send(call_name, _self)
      }
    end
    # ex.
    # def bank( _self = self.itself )
    #   FFS.event_get_bank(_self)
    # end

    ### Aliases.
    alias bknum   bank

    alias ch      channel
    alias chan    channel
    alias ctrl    control

    alias pgnum   program
    alias prenum  program

    alias sfid    sfont_id

    alias val     value
    alias vel     velocity
    alias velc    velocity

    #
    #
    #
    def from_midi_event( midi_ev, _self = self.itself )
      FFS.event_from_midi_event(_self, midi_ev)
    end

    # getter+setter.
    #
    #
    def dest( _self = self.itself )
      FFS.event_get_dest(_self)
    end
    def dest=( _dst, _self = self.itself )
      FFS.event_set_dest(_self, dest: _dst)
    end
    alias dst dest
    alias dst= dest=

    #
    def source( _self = self.itself )
      FFS.event_get_source(_self)
    end
    def source=( _src, _self = self.itself )
      FFS.event_set_source(_self, src: _src)
    end
    alias src source
    alias src= source=

    # setters (types)
    #
    #
    EVENT_TYPE_ARY = [
      #
      :note, :noteon, :noteoff,
      :all_sounds_off, :all_notes_off,
      :bank_select,
      :program_change, :program_select,
      :pitch_bend, :pitch_wheelsens,
      :modulation,

      #
      :sustain,
      :control_change,
      :pan,
      :volume,
      :reverb_send,
      :chorus_send,
      :timer,
      :channel_pressure, :key_pressure,
      :system_reset,

      #
      :unregistering,
      :scale,
      # last.
    ]
    def set_type_alias( kn )
      ret = kn.to_s.downcase.to_sym
      case kn
      when /^cc$/i
        ret = :control_change
      when /^mod$/i
        ret = :modulation
      when /^pc$/i
        ret = :program_change
      when /^psel$/i
        ret = :program_select
      when /^ps$/i
        ret = :program_select
      end

      ret
    end

    def set_type( type, ... )
      _type = set_type_alias(type)

      type_s = _type.to_s.downcase
      unless EVENT_TYPE_ARY.include? type_s.to_sym
        raise "No such event type: #{type}. Select one of #{EVENT_TYPE_ARY}."
      end

      #
      meth_type = "event_" + type_s
      FFS.send(meth_type, self, ...)

    end

    # action (set_type).
    #
    #
    tmp = EVENT_TYPE_ARY.dup
    tmp = tmp - [ :scale ]
    tmp.each do |_meth|
      #
      meth_name = "set_" + _meth.to_s

      #
      define_method(meth_name){| *args, **kwargs |
        self.send('set_type', _meth, *args, **kwargs)
      }
    end
    def set_scale( v )
      set_type(:scale, scale: v)
    end

  end
end




#### endof filename: fiddle-fluidstynth/sequencer/events.rb
