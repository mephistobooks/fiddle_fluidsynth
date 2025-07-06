#
# filename: fiddle-fluidstynth/synth/effect/ladspa.rb
#


# References
# - fluidstynth.org, [API Reference](https://www.fluidsynth.org/api/modules.html)
#
class FiddleFluidSynth

  # Functions for configuring the LADSPA effects unit.
  # ==== References
  # - API Reference, Synthesizer/[Effect - LADSPA](https://www.fluidsynth.org/api/group__ladspa.html)
  # - [library fiddle](https://docs.ruby-lang.org/ja/latest/library/fiddle.html)
  #

  #
  module C

    # Lifecycle Functions.
    #
    #


    # Functions.
    #
    #

    # Activate the LADSPA fx instance and each configured effect.
    extern 'int fluid_ladspa_activate(fluid_ladspa_fx_t*)'

    # Create and add a new audio buffer.
    extern 'int fluid_ladspa_add_buffer(fluid_ladspa_fx_t*, char*)'

    # Create an instance of a LADSPA plugin as an effect.
    extern 'int fluid_ladspa_add_effect(fluid_ladspa_fx_t*, void*, void*, void*)'

    # Check if a named user buffer exists.
    extern 'int fluid_ladspa_buffer_exists(fluid_ladspa_fx_t*, void*)'

    # Do a sanity check for problems in the LADSPA setup.
    extern 'int fluid_ladspa_check(fluid_ladspa_fx_t*, void*, int)'

    # Deactivate a LADSPA fx instance and all configured effects.
    extern 'int fluid_ladspa_deactivate(fluid_ladspa_fx_t*)'

    # Check if the effect plugin supports the run_adding and
    # set_run_adding_gain interfaces necessary for output mixing.
    extern 'int fluid_ladspa_effect_can_mix(fluid_ladspa_fx_t*, void*)'

    # Connect an effect audio port to a host port or buffer.
    extern 'int fluid_ladspa_effect_link(fluid_ladspa_fx_t*, void*, void*, void*)'

    # Check if the named port exists on an effect.
    extern 'int fluid_ladspa_effect_port_exists(fluid_ladspa_fx_t*, void*, void*)'

    # Set the value of an effect control port.
    extern 'int fluid_ladspa_effect_set_control(fluid_ladspa_fx_t*, void*, void*, float)'

    # Set if the effect should replace everything in the output buffers
    # (mix = 0, default) or add to the buffers with a fixed gain (mix = 1).
    extern 'int fluid_ladspa_effect_set_mix(fluid_ladspa_fx_t*, void*, int, float)'

    # Check if a named host port exists.
    extern 'int fluid_ladspa_host_port_exists(fluid_ladspa_fx_t*, void*)'

    # Check if the LADSPA engine is currently used to render audio.
    extern 'int fluid_ladspa_is_active(fluid_ladspa_fx_t*)'

    # Reset the LADSPA effects engine.
    extern 'int fluid_ladspa_reset(fluid_ladspa_fx_t*)'

    # Return the LADSPA effects instance used by FluidSynth.
    extern 'fluid_ladspa_fx_t* fluid_synth_get_ladspa_fx(fluid_synth_t*)'


  end
end


# Lifecycle Functions.
#
#


# Functions.
#
#
class FiddleFluidSynth

  #
  def ladspa_activate( fx )
    ret = C.fluid_ladspa_activate(fx)
    ret
  end

  def ladspa_add_buffer( fx, name: )
    ret = C.fluid_ladspa_add_buffer(fx,name)
    ret
  end

  def ladspa_add_effect( fx, name: , lib_name: , plugin_name: )
    ret = C.fluid_ladspa_add_effect(fx,name)
    ret
  end

  def ladspa_buffer_exists( fx, name: )
    ret = C.fluid_ladspa_buffer_exists(fx,name)
    ret
  end

  def ladspa_check( fx, err: , err_size: )
    ret = C.fluid_ladspa_check(fx,err,err_size)
    ret
  end

  def ladspa_deactivate( fx )
    ret = C.fluid_ladspa_deactivate(fx)
    ret
  end

  def ladspa_effect_can_mix( fx, name: )
    ret = C.fluid_ladspa_effect_can_mix(fx,name)
    ret
  end

  def ladspa_effect_link( fx, effect_name: , port_name: , name: )
    ret = C.fluid_ladspa_effect_link(fx,effect_name,port_name,name)
    ret
  end

  def ladspa_effect_port_exists( fx, effect_name: , port_name: )
    ret = C.fluid_ladspa_effect_port_exists(fx,effect_name,port_name)
    ret
  end

  def ladspa_effect_set_control( fx, effect_name: , port_name: , val: )
    ret = C.fluid_ladspa_effect_set_control(fx,effect_name,port_name,val)
    ret
  end

  def ladspa_effect_set_mix( fx, name: , mix: , gain: )
    ret = C.fluid_ladspa_effect_set_mix(fx,name,mix,gain)
    ret
  end

  #
  def ladspa_host_port_exists( fx, name: )
    ret = C.fluid_ladspa_host_port_exists(fx,name)
    ret
  end

  def ladspa_is_active( fx )
    ret = C.fluid_ladspa_is_active(fx)
    ret
  end

  def ladspa_reset( fx )
    ret = C.fluid_ladspa_reset(fx)
    ret
  end

  def synth_ladspa_get_ladspa_fx( synth=self.synth )
    ret = C.fluid_synth_get_ladspa_fx(synth)
    ret
  end


end


#### endof filename: fiddle-fluidstynth/synth/effect/ladspa.rb
