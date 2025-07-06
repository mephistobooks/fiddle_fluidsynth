#
# filename: fiddle-fluidstynth/midi_input/router.rb
#


# References
# - fluidsynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Rule based transformation and filtering of MIDI events.
  # ==== References
  # - API Reference, MIDI Input/[MIDI Router](https://www.fluidsynth.org/api/group__midi__router.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  # MIDI router rule type.
  #
  #
  enum(
    :fluid_midi_router_rule_type,
    FLUID_MIDI_ROUTER_RULE_NOTE:             nil,
    FLUID_MIDI_ROUTER_RULE_CC:               nil,
    FLUID_MIDI_ROUTER_RULE_PROG_CHANGE:      nil,
    FLUID_MIDI_ROUTER_RULE_PITCH_BEND:       nil,
    FLUID_MIDI_ROUTER_RULE_CHANNEL_PRESSURE: nil,
    FLUID_MIDI_ROUTER_RULE_KEY_PRESSURE:     nil,
    FLUID_MIDI_ROUTER_RULE_COUNT:            nil,
  )

  #
  module C


    # Lifecycle Functions (MIDI Router).
    #
    #

    # Create a new midi router.
    extern 'fluid_midi_router_t* new_fluid_midi_router' +
      '(fluid_settings_t*, handle_midi_event_func_t, void*)'

    # Delete a MIDI router instance.
    extern 'void delete_fluid_midi_router(fluid_midi_router_t*)'


    # Lifecycle Functions (MIDI Router Rule).
    #
    #

    # Create a new MIDI router rule.
    extern 'fluid_midi_router_rule_t* new_fluid_midi_router_rule(void)'

    # Free a MIDI router rule.
    extern 'void delete_fluid_midi_router_rule(fluid_midi_router_rule_t*)'


    # Functions.
    #
    #

    #  MIDI event callback function to display event information to stdout.
    extern 'int fluid_midi_dump_postrouter(void*, fluid_midi_event_t*)'

    # MIDI event callback function to display event information to stdout.
    extern 'int fluid_midi_dump_prerouter(void*, fluid_midi_event_t*)'

    # Add a rule to a MIDI router.
    extern 'int fluid_midi_router_add_rule' +
      '(fluid_midi_router_t*, fluid_midi_router_rule_t*, int)'

    # Clear all rules in a MIDI router.
    extern 'int fluid_midi_router_clear_rules(fluid_midi_router_t*)'

    # Handle a MIDI event through a MIDI router instance.
    extern 'int fluid_midi_router_handle_midi_event(void*, fluid_midi_event_t*)'

    # Set the channel portion of a rule.
    extern 'void fluid_midi_router_rule_set_chan' +
      '(fluid_midi_router_rule_t*, int, int, float, int)'

    # Set the first parameter portion of a rule.
    extern 'void fluid_midi_router_rule_set_param1' +
      '(fluid_midi_router_rule_t*, int, int, float, int)'

    # Set the second parameter portion of a rule.
    extern 'void fluid_midi_router_rule_set_param2' +
      '(fluid_midi_router_rule_t*, int, int, float, int)'

    # Set a MIDI router to use default "unity" rules.
    extern 'int fluid_midi_router_set_default_rules(fluid_midi_router_t*)'


  end
end


# Lifecycle Functions.
#
#
class FiddleFluidSynth

  ### Router.

  #
  # ==== See Also
  # - fluid_synth_handle_midi_event()
  # - util/callback.rb
  #
  # def midi_router_new( handler: , data: , settings: self.settings )
  def self.midi_router_new( settings: ,
                            handler: Synth_handle_midi_event_default,
                            handler_data: nil )
    ret = C.new_fluid_midi_router(settings, handler, handler_data)
    ret
  end
  def midi_router_new( settings = self.settings,
                       handler: Synth_handle_midi_event_default,
                       handler_data: nil )
    self.class.midi_router_new(
      settings: settings, handler: handler, handler_data: handler_data)
  end

  def self.midi_router_delete( router )
    ret = C.delete_fluid_midi_router(router)
    ret
  end
  def midi_router_delete( router )
    self.class.midi_router_delete(router)
  end

  ### Router Rule.

  def self.midi_router_rule_new
    ret = C.new_fluid_midi_router_rule()
    ret
  end
  def midi_router_rule_new
    self.class.midi_router_rule_new
  end

  def self.midi_router_rule_delete( rule )
    ret = C.delete_fluid_midi_router_rule(rule)
    ret
  end
  def midi_router_rule_delete( rule )
    self.class.midi_router_rule_delete(rule)
  end

end

# Functions (Router).
#
#
class FiddleFluidSynth

  def midi_dump_postrouter( data: , event: )
    ret = C.fluid_midi_dump_postrouter(data, event)
    ret
  end

  def midi_dump_prerouter( data: , event: )
    ret = C.fluid_midi_dump_prerouter(data, event)
    ret
  end

end


# Functions (Router Rules).
#
#
class FiddleFluidSynth

  #
  def midi_router_add_rule( router, rule: , type: )
    ret = C.fluid_midi_router_add_rule(router, rule, type)
    ret
  end

  def midi_router_clear_rules( router )
    ret = C.fluid_midi_router_clear_rules(router)
    ret
  end

  #
  # ==== See Also
  # - util/callback.rb
  #
  def self.midi_router_handle_midi_event( data, event )
    ret = C.fluid_midi_router_handle_midi_event(data, event)
    ret
  end
  def midi_router_handle_midi_event( data, event )
    self.class.midi_router_handle_midi_event(data, event)
  end

  #
  def midi_router_rule_set_chan( rule, min: , max: , mul: , add: )
    ret = C.fluid_midi_router_rule_set_chan(rule,min,max,mul,add)
    ret
  end
  alias midi_router_rule_set_ch midi_router_rule_set_chan

  def midi_router_rule_set_param1( rule, min: , max: , mul: , add: )
    ret = C.fluid_midi_router_rule_set_param1(rule,min,max,mul,add)
    ret
  end

  def midi_router_rule_set_param2( rule, min: , max: , mul: , add: )
    ret = C.fluid_midi_router_rule_set_param2(rule,min,max,mul,add)
    ret
  end

  #
  def midi_router_set_default_rules( router )
    ret = C.fluid_midi_router_set_default_rules(router)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/midi_input/router.rb
