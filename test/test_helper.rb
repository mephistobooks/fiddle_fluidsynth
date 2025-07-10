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

def cleanup_test_files
  # 不要なファイルを削除する処理
  output_file = "#{__dir__}/../fluidsynth.wav"
  $stderr.puts "Searching for a file: #{output_file}"
  if File.exist?(output_file)
    File.delete(output_file)
    $stderr.puts "Deleted garbage file: #{output_file}"
  else
    $stderr.puts "Does NOT exist: #{output_file}"
  end
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


at_exit do
  # audio_output_test creates 'fluidsynth.wav', so ...
  cleanup_test_files()
end


####
