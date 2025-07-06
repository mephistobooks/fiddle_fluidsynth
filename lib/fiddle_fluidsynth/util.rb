#
# filename: fiddle-fluidsynth/util.rb
#


#
#
#
class FiddleFluidSynth
  module C

  #
  module Interface
    module Settings; end
  end

  #
  module Interface
    module AudioOutputDriver; end
  end

  end
end


#
#
#
require_relative "./util/util"
require_relative "./util/callback"
require_relative "./util/module_hier"

# in util-after.rb
# require_relative "./util/settings"


#### endof filename: fiddle-fluidsynth/util.rb
