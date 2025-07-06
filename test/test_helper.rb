# frozen_string_literal: true
#
#

#
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "fiddle_fluidsynth"

#
require "test-unit"
class Test::Unit::TestCase
  FFS = FiddleFluidSynth
end


# output redirect function: $stderr to /dev/null.
#
#
def stderr_to_devnull( &blk )
  stderr_orig = $stderr.dup
  $stderr.reopen(File::NULL, "w")

  #
  ret = blk.()

  $stderr.reopen(stderr_orig)
  ret
end


####
