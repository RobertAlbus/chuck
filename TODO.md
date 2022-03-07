# Things to implement, in no order

## R2D64
- Need some more things
  - LFO but noise (separate tool)
  - velocity
  - automation clip LOOPS
  - processing effects
  - instruments
  - copy constructor?


## R2D50
- Need some more things
  - LFO (with different oscs and noise as well)
  - velocity
  - knob automations (automation clips)
  - mixer
  - processing effects
  - instruments
  - copy constructor (would potentially
   be useful when trying to re-approach multi-voice)


## 2022 Jan 04?

- chord generator
- chord modifier (inversions etc)
- higher order midi aggregate
  - represent an entire tonal space
    - all MIDI notes for that scale in all octaves
    - chords in that tonal space
- filter cut offs
  - step sequncer?
  - other, more continuous change style thing?
- step sequencer agregates (for polyphony and such)
- tool for arrangement

- array utils
  - transpose values
  - cat (unless there is a splat style operator in ChucK)
  - flatten
  - filter for unique

## 2022 Jan 19
- high value
  - ~~MultiOscSynth, a monophonic aggregate of SingleOscSynth~~
  - polyphonic version of MultiOscSynth
  - LFO controller (have ADSR controller already)
  - Arrangement facilities would be very high milage
    - song sections
    - jump-to, looping
    - swing and time mods
  - polyphonic StepSequencer
  - MIDI timeline so that notes don't have to fall on the step
  - ~~base classes that can be used to make interop possible~~
    - ~~such as Keyable (keyOn, keyOff) for OscSynth and StepSequencers~~
    - INVALIDATED: no multiple inheritance
  - mixer!

- Complex envelope controller of some kind? lower priority
