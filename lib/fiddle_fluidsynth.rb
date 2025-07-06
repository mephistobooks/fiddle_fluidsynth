# frozen_string_literal: true

#
# filename: fiddle_fluidsynth.rb
#

#
#
#
require 'fiddle/import'

#
require_relative "fiddle_fluidsynth/core_ext/fiddle"
require_relative "fiddle_fluidsynth/core_ext/module"

#
#
#
class FiddleFluidSynth
  FFS = FiddleFluidSynth
  module C
    extend Fiddle::Importer
  end
end

#
require_relative "fiddle_fluidsynth/version"



#
#
#
require_relative "fiddle_fluidsynth/util"
require_relative "fiddle_fluidsynth/fiddle_fluidsynth"

#
require_relative "fiddle_fluidsynth/types"

#
require_relative "fiddle_fluidsynth/audio_output"
require_relative "fiddle_fluidsynth/command_interface"
require_relative "fiddle_fluidsynth/logging"
require_relative "fiddle_fluidsynth/midi_input"
require_relative "fiddle_fluidsynth/sequencer"
require_relative "fiddle_fluidsynth/misc"
require_relative "fiddle_fluidsynth/settings"
require_relative "fiddle_fluidsynth/soundfonts"
require_relative "fiddle_fluidsynth/synth"

#
#
#
require_relative "fiddle_fluidsynth/util-after"


#### endof filename: fiddle_fluidsynth.rb
