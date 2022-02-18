# R2D45

## Today's goals
### Add pattern toggle and mute toggle to each instrument
Add toggles to instruments that can be triggered with MIDI. This allows me to jam on the song in a mroe arrangement-like fashion.

## Today's outcomes
- Added MIDI control to toggle a mute on each channel

## Lessons / Thoughts
- I was hoping to split `source.ck` across multiple files
  - didn't work, importing in `r2d46.ck` or in `source.ck`
  - global variables from one file are not available in another
- I might want to add an ADSR to the mute toggle
  - ADSR might make the mute toggle sound better/musical
  - check if mute is active based on ADSR state
  - this probably is only necessary for MIDI trigger, because programmatic trigger will be perfectly timed
  - might want `on()` and `off()` functions rather than `toggle()` for programmatic mute toggling
