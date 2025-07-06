#
# filename: fiddle-fluidsynth/util/callback.rb
#


#
require 'ffi'


#
#
#
class FiddleFluidSynth

  #
  @@error_in_callback = nil
  def self.error_in_callback=(v); @@error_in_callback = v; end
  def self.error_in_callback; @@error_in_callback; end

  #
  def self.raise_error_in_callback( notify_f: false )
    #raise @@error_in_callback unless @@error_in_callback.nil?
    unless @@error_in_callback.nil?
      unless notify_f
        raise @@error_in_callback
      else
        $stderr.puts "#{@@error_in_callback.message}:" +
          "#{@@error_in_callback.class}"
        @@error_in_callback.backtrace.each do |_e|
          $stderr.puts "#{_e}"
        end
      end
    end
    @@error_in_callback
  end
  def raise_error_in_callback( notify_f: false )
    self.class.raise_error_in_callback(notify_f: notify_f)
  end

  def self.notify_error_in_callback
    self.raise_error_in_callback(notify_f: true)
  end
  def notify_error_in_callback
    self.class.notify_error_in_callback(notify_f: notify_f)
  end


  # コールバック関数は，FiddleではなくFFIで用意する必要がある.
  # (FiddleだとRubyが止まる. Fiddle::Closure::BlockCaller と
  # FFI::Function との GVLの扱いの違いに由来する)
  # ==== References
  # - FFI, [Types](https://github.com/ffi/ffi/wiki/Types).
  #

  #
  def self.__create_func_obj( return_type: , argtypes_ary: [] ,
                              thread_f: false, &blk )
    func_obj = FFI::Function.new(return_type, argtypes_ary) do |*args|
      # NOTE:
      # without Thread.new{...}, the callback is locked at
      # fluid_sequencer_send_at(). i dont know why...
      #
      if thread_f
        Thread.new{
          # error_in_callback = nil
          begin
            blk.(*args)
          rescue ScriptError =>ex
            @@error_in_callback = ex
          rescue =>ex
            @@error_in_callback = ex
          end
        }
      else
        # error_in_callback = nil
        begin
          blk.(*args)
        rescue ScriptError =>ex
          @@error_in_callback = ex
        rescue =>ex
          @@error_in_callback = ex
        end
      end
    end

    # To avoid the GC, we have to have the reference to the object
    # of FFI::Function...
    #
    @func_obj_storage ||= {}
    @func_obj_storage[func_obj.object_id] = func_obj

    ret = func_obj
    ret
  end

  def self.create_func_obj_ab( return_type: , argtypes_ary: [] ,
                               thread_f: false, &blk )
    # func_obj = FFI::Function.new(return_type, argtypes_ary) do |a, b|
    func_obj = __create_func_obj(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f) do |a, b|
      blk.(a,b)
    end

    ret = func_obj
    ret
  end

  def self.create_func_obj_a4( return_type: , argtypes_ary: [] ,
                               thread_f: false, &blk )
    func_obj = __create_func_obj(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f) do |a,b,c,d|
      blk.(a,b,c,d)
    end

    ret = func_obj
    ret
  end

  def self.create_func_obj_a3( return_type: , argtypes_ary: [] , 
                               thread_f: false, &blk )
    func_obj = __create_func_obj(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f) do |a,b,c|
      blk.(a,b,c)
    end

    ret = func_obj
    ret
  end

  def self.create_func_obj_a1( return_type: , argtypes_ary: [] ,
                               thread_f: false, &blk )
    func_obj = __create_func_obj(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f) do |a|
      blk.(a)
    end

    ret = func_obj
    ret
  end

  #
  def self.create_func_obj_a6( return_type: , argtypes_ary: [] ,
                               thread_f: false, &blk )
    func_obj = __create_func_obj(
      return_type: return_type, argtypes_ary: argtypes_ary) do |a,b,c, d,e,f|
        blk.(a,b,c, d,e,f)
    end

    ret = func_obj
    ret
  end

  #
  #
  #
  def self.create_func_ptr( func_obj )
    #
    ptr_obj = Fiddle::Pointer.new(func_obj.to_ptr.address)
    ret = ptr_obj
    ret
  end

  #
  # ==== Desc.
  # @func_obj に保存しておかないと，GCでFFI::Functionオブジェクトが
  # 削除される
  #
  def self.define_callback_ab( return_type: , argtypes_ary: [],
                               thread_f: false, &blk)
    # @func_ptr_storage ||= {}

    #
    func_obj = create_func_obj_ab(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b|
      blk.call(a,b)
    }

    #
    func_ptr = create_func_ptr(func_obj)
    # @func_ptr_storage[func_ptr.object_id] = func_ptr

    ret = func_ptr
    ret
  end
  def define_callback_ab( return_type: , argtypes_ary: [],
                          thread_f: false, &blk )
    self.class.define_callback_ab(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b|
        blk.call(a,b)
      }
  end

  #
  def self.define_callback_a4( return_type: , argtypes_ary: [],
                               thread_f: false, &blk)
    #
    func_obj = create_func_obj_a4(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c,d|
      blk.call(a,b,c,d)
    }

    #
    func_ptr = create_func_ptr(func_obj)
    ret = func_ptr
    ret
  end
  def define_callback_a4( return_type: , argtypes_ary: [] ,
                          thread_f: false, &blk )
    self.class.define_callback_a4(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c,d|
        blk.call(a,b,c,d)
      }
  end

  #
  def self.define_callback_a3( return_type: , argtypes_ary: [],
                               thread_f: false, &blk)
    #
    func_obj = create_func_obj_a3(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c|
      blk.call(a,b,c)
    }

    #
    func_ptr = create_func_ptr(func_obj)
    # @func_ptr_storage[func_ptr.object_id] = func_ptr

    ret = func_ptr
    ret
  end
  def define_callback_a3( return_type: , argtypes_ary: [],
                          thread_f: false, &blk )
    self.class.define_callback_a3(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c|
        blk.call(a,b,c)
      }
  end

  #
  def self.define_callback_a1( return_type: , argtypes_ary: [],
                               thread_f: false, &blk)
    #
    func_obj = create_func_obj_a1(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a|
      blk.call(a)
    }

    #
    func_ptr = create_func_ptr(func_obj)

    ret = func_ptr
    ret
  end
  def define_callback_a1( return_type: , argtypes_ary: [] ,
                          thread_f: false, &blk )
    self.class.define_callback_a1(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a|
        blk.call(a)
      }
  end

  #
  def self.define_callback_a6( return_type: , argtypes_ary: [],
                               thread_f: false, &blk)
    #
    func_obj = create_func_obj_a6(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c,d,e,f|
      blk.call(a,b,c, d,e,f)
    }

    #
    func_ptr = create_func_ptr(func_obj)

    ret = func_ptr
    ret
  end
  def define_callback_a6( return_type: , argtypes_ary: [], 
                          thread_f: false, &blk )
    self.class.define_callback_a6(
      return_type: return_type, argtypes_ary: argtypes_ary,
      thread_f: thread_f){|a,b,c,d,e,f|
        blk.(a,b,c,d,e,f)
      }
  end

end


#
#
#
class FiddleFluidSynth

  # define callback function for fluid_settings_foreach().
  # ====
  #
  # ==== See Also
  # - fluid_settings_foreach_option()
  # - .#define_tick_callback()
  #
  #
  def self.define_settings_foreach_callback( &blk )
    self.define_callback_a3(
      return_type: :void,
      argtypes_ary: [:pointer, :string, :int]){|data, name, type|
        begin
          blk.call(data, name, type)
          #blk.call(data, cur_tick)
        rescue =>ex
          raise ex
        end
      }
  end

  def define_settings_foreach_callback( &blk )
    self.class.define_settings_foreach_callback(){|a,b,c|
      blk.call(a,b,c)
    }
  end

  # define callback function for fluid_settings_foreach_option().
  # ====
  #
  # ==== See Also
  # - fluid_settings_foreach()
  #
  def self.define_settings_foreach_option_callback( &blk )
    self.define_callback_a3(
      return_type: :void,
      argtypes_ary: [:pointer, :string, :string]){|data, name, option|
        blk.call(data, name, option)
      }
  end

  def define_settings_foreach_option_callback( &blk )
    self.class.define_settings_foreach_option_callback(){|a,b,c|
      blk.call(a,b,c)
    }
  end

end


#
#
#
class FiddleFluidSynth

  # define tick callback function for fluid_player_set_tick_callback().
  # ====
  #
  # ==== See Also
  # - fluid_player_set_tick_callback()
  # - fluid_player_set_playback_callback()
  #
  # - mid_input/: fluid_synth_handle_midi_event()
  # - soundfont/loader: fluid_sfloader_set_callbacks()
  #
  # - logging/logging: fluid_set_log_function()
  #
  def self.define_tick_callback( &blk )
    self.define_callback_ab(
      return_type: :int, argtypes_ary: [:pointer, :int]){|data, cur_tick|
        blk.call(data, cur_tick)
      }
  end

  def define_tick_callback( &blk )
    self.class.define_tick_callback(){|a,b|
      blk.call(a,b)
    }
  end

  # define playback callback function.
  # ==== See Also
  # - fluid_player_set_tick_callback()
  # - fluid_synth_handle_midi_event()
  #
  def self.define_playback_callback( &blk )
    self.define_callback_ab(
      return_type: :int, argtypes_ary: [:pointer, :pointer]){|data, event|
        blk.call(data, event)
      }
  end
  def define_playback_callback( &blk )
    self.class.define_playback_callback(){|a,b|
      blk.(a,b)
    }
  end


  # fluid_audio_func_t.
  # ==== Desc
  # passed to audio_driver_new2().
  #
  def self.define_audio_func( &blk )
    self.define_callback_a6(
      return_type: :int, 
      argtypes_ary: [:pointer, :int,
                     :int, :pointer, :int, :pointer, ]
    ){|data, len, nfx, fx, nout, out|
      blk.(data, len, nfx, fx, nout, out)
    }
  end
  def define_audio_func( &blk )
    self.class.define_audio_func(){|a,b,c,d,e,f|
      blk.(a,b,c,d,e,f)
    }
  end


  # this is meaningless for cmd_handler.
  # please use cmd_handler_new(), cmd_handler_new2() before
  # fluid_command(). and that's it.
  # ==== See Also
  # - Command Interface/Command Handler
  #


  # define sequencer client (sequencer event callback).
  # ==== See Also
  # - fluid_sequencer_register_client()
  # - API Reference: MIDI sequencer.
  #
  def self.define_event_callback( &blk )
    self.define_callback_a4(
      return_type: :void,
      argtypes_ary: [:uint, :pointer, :pointer, :pointer],
      thread_f: true
    ){|time, event, seq, data|
      blk.(time,event,seq,data)
    }
  end
  def define_event_callback( &blk )
    self.class.define_event_callback(){|a,b,c,d|
      blk.(a,b,c,d)
      #Thread.new{ blk.(a,b,c,d) }
    }
  end

  # define midi_event_func (handle_midi_event_func_t).
  # ==== See ALso
  # - midi_input/driver.rb
  # - midi_input/router.rb
  #
  def self.define_midi_event_func( &blk )
    self.define_callback_ab(
      return_type: :int, argtypes_ary: [:pointer, :pointer,]){|data, ev|
        blk.call(data,ev)
      }
  end
  def define_midi_event_func( &blk )
    self.class.define_midi_event_func(){|data, ev|
      blk.call(data,ev)
    }
  end
  Midi_router_handle_midi_event_default = define_midi_event_func{|data, ev|
    midi_router_handle_midi_event(data, ev)
  }
  Synth_handle_midi_event_default = define_midi_event_func{|data, ev|
    synth_handle_midi_event(data, ev)
  }


  # define midi_tick_func.
  #
  #
  def self.define_midi_tick_func( &blk )
    self.define_callback_ab(
      return_type: :int, argtypes_ary: [:pointer, :int,]){|data, tick|
        blk.call(data,tick)
      }
  end
  def define_midi_tick_func( &blk )
    self.class.define_midi_tick_func(){|data, tick|
      blk.call(data,tick)
    }
  end


  # define sfloader callbacks.
  #
  #
  def self.define_sfloader_callback_close( &blk )
    self.define_callback_a1(
      return_type: :int, argtypes_ary: [:pointer,]){|handle|
        blk.call(handle)
      }
  end
  def define_sfloader_callback_close( &blk )
    self.class.define_sfloader_callback_close(){|handle|
      blk.call(handle)
    }
  end

  def self.define_sfloader_callback_open( &blk )
    self.define_callback_a1(
      return_type: :void,
      argtypes_ary: [:pointer,]){|filename|
        blk.call(filename)
      }
  end
  def define_sfloader_callback_open( &blk )
    self.class.define_sfloader_callback_open(){|filename|
      blk.call(filename)
    }
  end

  def self.define_sfloader_callback_read( &blk )
    self.define_callback_a3(
      return_type: :int,
      argtypes_ary: [:pointer,:long_long,:pointer,]){|buf,count,handle|
        blk.call(buf,count,handle)
      }
  end
  def define_sfloader_callback_read( &blk )
    self.class.define_sfloader_callback_read(){|buf,count,handle|
      blk.call(buf,count,handle)
    }
  end

  def self.define_sfloader_callback_seek( &blk )
    self.define_callback_a3(
      return_type: :void,
      argtypes_ary: [:pointer,:long_long,:pointer,]){|handle,offset,origin|
        blk.call(handle,offset,origin)
      }
  end
  def define_sfloader_callback_seek( &blk )
    self.class.define_sfloader_callback_seek(){|handle,offset,origin|
      blk.call(handle,offset,origin)
    }
  end

  def self.define_sfloader_callback_tell( &blk )
    self.define_callback_a1(
      return_type: :long_long,
      argtypes_ary: [:pointer,]){|handle|
        blk.call(handle)
      }
  end
  def define_sfloader_callback_tell( &blk )
    self.class.define_sfloader_callback_tell(){|handle|
      blk.call(handle)
    }
  end


  # log function.
  #
  #
  def self.define_log_function( &blk )
    self.define_callback_a3(
      return_type: :void,
      argtypes_ary: [:int, :pointer, :pointer]
    ){|level, message, data|
        blk.call(level,message,data)
      }
  end
  def define_log_function( &blk )
    self.class.define_log_function(){|level, message, data|
      blk.call(level,message,data)
    }
  end


end




#### endof filename: fiddle-fluidsynth/util/callback.rb
