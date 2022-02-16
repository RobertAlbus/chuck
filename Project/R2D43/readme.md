# R2D42

## Today's goals
### Explore polyphony
Want to handle multiple voices at the same time, possibly from a multi-voice step sequencer.

## Today's outcomes
- Considered a polyphonous Instrument construct
- best approach is probably to have multiple mono Instruments and StepSequencers and just program them polyphonously

## Lessons
- polyphonous Instrument construct presents a challenge with tracking which voice is being triggered off, and when. 
  - a better approach might be a multi-voice step sequencer, such that steps is of type `float[][]` where each array is for a specific voice
  - might be even better to just have multiple mono step sequencers, and possibly aggregate into a meta stepsequencer to give a single trigger point