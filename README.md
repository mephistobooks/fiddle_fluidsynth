# FiddleFluidsynth

A `fiddle` (`ffi` is partially used) wrapped [`libfluidsynth`](https://www.fluidsynth.org/). We can program/play the music from our code with this.

To experiment with that code, run `bin/console` for an interactive prompt.


## Requirements

`libfluidsynth` is required.

In macOS, do `brew install fluidsynth` and make symbolic link
`default.sf2` in `/opt/homebrew/share/fluid-synth/sf2/` for the default
SoundFont.

As for the default soundfont, I recommend GeneralUser GS 2.0.2 (`GeneralUser-GS.sf2`), created by S. Christian Collins. We can download it from [his site](https://www.schristiancollins.com/generaluser.php). This package includes some MIDI files for demo.

[FluidR3 GM](https://musical-artifacts.com/artifacts/738) soundfont by Frank Wen and Toby Smithe is also great. We can download them on [Musical Artifact](https://musical-artifacts.com/).

Other soundfont resources are listed in the FluidSynth User Manual Wiki, [SoundFont](https://github.com/FluidSynth/fluidsynth/wiki/SoundFont) chapter.

## Developed Environment

Developed/Tested environments are as follows:

- libfluidsynth 2.4.6
- Ruby 3.3.0
- macOS 15.5


## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```


## Usage

See `examples/` directory.



## Technical info

`fiddle` is used to wrap and `ffi` is partially used (for callback functions).


The Structure of classes/modules is:

- FiddleFluidSynth (class)      top.
    - (class/)instance methods are defined. These are almost one-to-one
      mapping with C-functions, but little bit ruby-fied.
    - utility methods for shortcuts.
    - ~~`FiddleFluidSynth#object` (this might be removed...?)
        the method for referencing to the instance hierarchy~~.
- FiddleFluidSynth::C (module)   direct mapping for C-functions.


Ruby-fication is actually not enough and work in progress...


### Attention on callback functions

If we use the callbacks of FiddleFluidSynth, including `each_something{ ... }`-
code blocks, we have to have special attention to our codes.

Because the code blocks of them are out of our Ruby code once,
we could not catch Exceptions correctly.

__I highly recommend that code blocks for the callbacks should be
short as far as we can, or use methods which are tested well.__

__and also do `FiddleFluidSynth.#raise_error_in_callback` after
some main routine to get the errors in callback function.__


- Settings
    - `fluid_settings_foreach()`
    - `fluid_settings_foreach_option()`
    - =>`#each_setting()`, `#each_option_of()`
- Synthesizer
    - `fluid_synth_tuning_iteration_start()`, `fluid_synth_tuning_iteration_next()`
    - Not Yet.
- SoundFont
    - `fluid_sfont_iteration_start()`, `fluid_sfont_iteration_next()`
    - =>`#each_preset()`

- callback sample programs are `example/{ffs_fx, ffs_metronome, ffs_arpeggio, ffs_midiplay}.rb`.
- `each_*` sample programs are `example/{presets-each, settings}.rb`, etc.


## `libfluidsynth` and other MIDI/SoundFont-related apps and resources

- [libfluidsynth](https://www.fluidsynth.org/)
    - [User Documentation](https://www.fluidsynth.org/documentation/)
    - [Developper Documentation](https://www.fluidsynth.org/api/)
        - [API Reference](https://www.fluidsynth.org/api/modules.html)
        - [Setting Reference](https://www.fluidsynth.org/api/fluidsettings.html)

- [PolyPhone](https://www.polyphone.io/)  - the SoundFont editor. `brew install polyphone`
- [Sonic Pi](https://sonic-pi.net/)   - awesome DAW environment. Sonic Pi has nice tutorial and documents. We can write score and play in Ruby. `brew install sonic-pi`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at `https://github.com/mephistobooks/fiddle_fluidsynth`.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## DISCLAIMER

SoundFont® is a registered trademark of Creative Technology Ltd.


---
end.
