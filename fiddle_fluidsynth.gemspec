# frozen_string_literal: true

require_relative "lib/fiddle_fluidsynth/version"

Gem::Specification.new do |spec|
  spec.name = "fiddle_fluidsynth"
  spec.version = FiddleFluidSynth::VERSION
  spec.authors = ["YAMAMOTO, Masayuki"]
  spec.email = ["martin.route66.blues+github@gmail.com"]

  spec.summary = "fiddle-wrappered libfluidsynth."
  spec.description = "program/play (MIDI) music from your code."
  spec.homepage = "https://voidptrjp.blogspot.com/2025/07/fiddlefluidsynth.html"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mephistobooks/fiddle_fluidsynth"
  spec.metadata["changelog_uri"] = "https://github.com/mephistobooks/fiddle_fluidsynth/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "ffi", "~> 1.17"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
