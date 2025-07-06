#
# filename: fiddle-fluidstynth/sequencer/sequencer.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # MIDI event sequencer.
  # ==== References
  # - API Reference, [MIDI Sequencer](https://www.fluidsynth.org/api/group__sequencer.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #


  #
  module C

    # Typedefs.
    #
    #
    typealias 'fluid_event_callback_t', 'void*'


    # Lifecycle Functions (MIDI Sequencer).
    #
    #

    # Create a new sequencer object which uses the system timer.
    extern 'fluid_sequencer_t* new_fluid_sequencer(void)'

    # Create a new sequencer object.
    extern 'fluid_sequencer_t* new_fluid_sequencer2(int)'

    # Free a sequencer object.
    extern 'void delete_fluid_sequencer(fluid_sequencer_t*)'


    # Functions.
    #
    #

    # Transforms an incoming MIDI event (from a MIDI driver or MIDI router)
    # to a sequencer event and adds it to the sequencer queue for sending as
    # soon as possible.
    extern 'int fluid_sequencer_add_midi_event_to_buffer' +
      '(void*, fluid_midi_event_t*)'

    # Check if a client is a destination client.
    extern 'int fluid_sequencer_client_is_dest(fluid_sequencer_t*, int)'

    # Count a sequencers registered clients.
    extern 'int fluid_sequencer_count_clients(fluid_sequencer_t*)'

    # Get a client ID from its index (order in which it was registered).
    #
    extern 'fluid_seq_id_t fluid_sequencer_get_client_id' +
      '(fluid_sequencer_t*, int)'

    # Get the name of a registered client.
    extern 'char* fluid_sequencer_get_client_name(void*, short)'

    # Get the current tick of the sequencer scaled by the time scale
    # currently set.
    extern 'unsigned int fluid_sequencer_get_tick(fluid_sequencer_t*)'

    #  Get a sequencer's time scale.
    extern 'double fluid_sequencer_get_time_scale(fluid_sequencer_t*)'

    # Check if a sequencer is using the system timer or not.
    extern 'int fluid_sequencer_get_use_system_timer(fluid_sequencer_t*)'

    # Advance a sequencer.
    extern 'void fluid_sequencer_process(fluid_sequencer_t*, unsigned int)'

    # Register a sequencer client.
    extern 'fluid_seq_id_t fluid_sequencer_register_client' +
      '(fluid_sequencer_t*, char*, fluid_event_callback_t, void*)'

    # Registers a synthesizer as a destination client of the given sequencer.
    extern 'fluid_seq_id_t fluid_sequencer_register_fluidsynth' +
      '(fluid_sequencer_t*, fluid_synth_t*)'

    # Remove events from the event queue.
    extern 'void fluid_sequencer_remove_events' +
      '(fluid_sequencer_t*, fluid_seq_id_t, fluid_seq_id_t, int)'

    # Schedule an event for sending at a later time.
    extern 'int fluid_sequencer_send_at' +
      '(fluid_sequencer_t*, fluid_event_t*, unsigned int, int)'

    # Send an event immediately.
    extern 'void fluid_sequencer_send_now(fluid_sequencer_t*, fluid_event_t*)'

    # Set the time scale of a sequencer.
    extern 'void fluid_sequencer_set_time_scale(fluid_sequencer_t*, double)'

    # Unregister a previously registered client.
    extern 'void fluid_sequencer_unregister_client' +
      '(fluid_sequencer_t*, fluid_seq_id_t)'


  end
end


#
#
#
class FiddleFluidSynth
  module SequencerIF;
    module InstanceOnlyIF; end
  end

  #
  extend SequencerIF    # for class methods.
  include SequencerIF   # for instance methods.
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth
  module SequencerIF

    #
    def sequencer_new()
      deprecated_msg(__method__)
      deprecated_msg_instead('sequencer_new2(0)', meth: __method__)
      ret = C.new_fluid_sequencer()
      ret.extend(InstanceOnlyIF)
      ret
    end

    #
    # ==== Args
    # use_system_timer::
    #   If FALSE (0), call fluid_sequencer_process() to advance the sequencer
    #   and do NOT use the system timer.
    #   If TRUE, use the system timer (NOT recommended by the reference).
    #
    def sequencer_new2( use_system_timer = 0 )
      ret = C.new_fluid_sequencer2(use_system_timer)
      ret.extend(InstanceOnlyIF)
      ret
    end

    def sequencer_delete( sequencer )
      ret = C.delete_fluid_sequencer(sequencer)
      ret
    end

  end
end


# Functions.
#
#
class FiddleFluidSynth
  module SequencerIF


    #
    def sequencer_add_midi_event_to_buffer( data: , event: )
      ret = C.fluid_sequencer_add_midi_event_to_buffer(data, event)
      ret
    end

    #
    def sequencer_client_is_dest( seq, seq_id: )
      ret = C.fluid_sequencer_client_is_dest(seq, seq_id)
      ret
    end

    ### client-related.

    def sequencer_count_clients( seq )
      ret = C.fluid_sequencer_count_clients(seq)
      ret
    end
    def sequencer_get_client_id( seq, index: )
      ret = C.fluid_sequencer_get_client_id(seq, index)
      ret
    end

    def sequencer_get_client_name( seq, seq_id: )
      ret = C.fluid_sequencer_get_client_name(seq, seq_id)
      if ret.null?
        ret = nil
      else
        ret = ret.to_s
      end
      ret
    end

    ### .
    def sequencer_get_tick( seq )
      ret = C.fluid_sequencer_get_tick(seq)
      ret
    end

    def sequencer_get_time_scale( seq )
      ret = C.fluid_sequencer_get_time_scale(seq)
      ret
    end

    #
    def sequencer_get_use_system_timer( seq )
      # deprecated_msg(__method__)
      ret = C.fluid_sequencer_get_use_system_timer(seq)
      ret
    end
    def sequencer_use_system_timer?( seq )
      self.sequencer_get_use_system_timer(seq) != 0
    end
    def sequencer_nouse_system_timer?( seq )
      !(self.sequencer_use_system_timer?(seq))
    end

    #
    def sequencer_process( seq, msec: )
      ret = C.fluid_sequencer_process(seq, msec)
      ret
    end

    #
    #
    #
    def sequencer_register_client( seq, name: , event_callback: , data: )
      ret = C.fluid_sequencer_register_client(seq, name, event_callback, data)
      ret
    end

    #
    # def sequencer_register_fluidsynth( seq, synth: )
    def sequencer_register_fluidsynth( seq, synth )
      ret = C.fluid_sequencer_register_fluidsynth(seq, synth)
      ret
    end

    def sequencer_remove_events( seq, src_seq_id: , dst_seq_id: , type: )
      ret = C.fluid_sequencer_remove_events(seq, src_seq_id, dst_seq_id, type)
      ret
    end

    #
    def sequencer_send_at( seq, event: , time: , absolute: )
      ret = C.fluid_sequencer_send_at(seq, event, time, absolute)
      ret
    end

    def sequencer_send_now( seq, event: )
      ret = C.fluid_sequencer_send_now(seq, event)
      ret
    end

    #
    def sequencer_set_time_scale( seq, scale: )
      ret = C.fluid_sequencer_set_time_scale(seq, scale)
      ret
    end

    def sequencer_unregister_client( seq, seq_id: )
      ret = C.fluid_sequencer_unregister_client(seq, seq_id)
      ret
    end


  end
end


#
#
#
class FiddleFluidSynth
  module SequencerIF::InstanceOnlyIF
    [
      # add_midi_event_to_buffer().

      ### client info.
      :client_is_dest,
      :count_clients,

      #
      :get_client_id,
      :get_client_name,

      ### client management.
      :register_client,
      :register_fluidsynth,
      :unregister_client,

      ### sequencer event flow.
      :send_at, :send_now,
      :remove_events,

      ### sequencer behaviour.
      :process,
      :get_time_scale,
      :set_time_scale,

      ### sequencer info.
      :get_tick,
      :get_use_system_timer,

    ].each do |_meth|
      #
      meth_name = _meth
      call_name = 'sequencer_'+_meth.to_s

      #
      #ng. define_method(meth_name){| _self = self.itself, ... |
      #ng.   FFS.send(call_name, _self, ...)
      define_method(meth_name){| *args, **kwargs |
        FFS.send(call_name, self, *args, **kwargs)
      }
    end


    ### Aliases.

    #{
    #  :is_dest? => :client_is_dest,
    #}.each do |k, v|
    #end
    def is_dest?( ... )
      tmp = self.client_is_dest(...)
      ret = (tmp != 0)
      ret
    end
    def client_id( ... )
      tmp = self.get_client_id(...)
      ret = tmp
      ret
    end
    def client_name( ... )
      tmp = self.get_client_name(...)
      ret = tmp
      ret
    end

    alias time_scale get_time_scale
    def time_scale=( v )
      tmp = self.set_time_scale(scale: v)
      ret = tmp
      ret
    end

    #
    alias tick get_tick

    #
    alias use_system_timer  get_use_system_timer
    def use_system_timer?
      ret = (self.get_use_system_timer != 0)
      ret
    end

    def each_client_id( &blk )
      cnt = self.count_clients
      (0...cnt).each do |_i|
        cid = self.get_client_id(index: _i)
        blk.(cid)
      end
    end

  end
end


#### endof filename: fiddle-fluidstynth/sequencer/sequencer.rb
