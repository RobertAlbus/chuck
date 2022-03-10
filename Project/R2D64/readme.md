# R2D64

## Today's goals

### Integrate Mixer etc. into R2D50 file structure
- R2D50 implements a potential repo structure (expanded upone well in R2D58)
- add mixer and related utilities into the libs for this Project
- link existing sounds into the mixer, and --mix--

### Use automation clips in this arrangement
convert the MIDI controlled params to automation clips

## Today's outcomes
- migrated mixer lib files from R2D63
- convered file names to skewer-case

## Lessons / Thoughts
- Running everything in a single thread is a massive performance bottleneck
- I should explore some performance enhancements
- I should also explore cross-thread eventing
  - can I run pattern managers in another thread?
  - is it reasonable to send audio across threads?


## Fodder, and thoughts based on R2D58
- `CTRL + L|R` doesn't stop at underscores, but does stop at dashes
  - should convert file names to use dashes
- layer hierarchy seems like it should be:
  - core
  - foundation
  - instrument
  - pattern??
  - arrangement??
- there must be some pattern for a generic base step sequencer
  - I want a step sequencer for Instruments               (instrument signals)
  - I want a step sequencer for AutomationEnvelope values (control signals)
  - I want a step sequencer for probably other things???
  
