# R2D40

## Today's goals
### Look into Stereo Chugens/Chubgraphs/etc
Would be great to have stereo-capable synthesizers. It will be interesting down the road to figure out panning (mono and stereo sources), width control, etc.

### Create an InstrumentStepSequencer
There are naive step sequencer implementations in the Foundation layer. Having a universal step sequencer that can operate on any instrument seems like a great idea. 

Down the road, it might be nice to use a step sequencer to control non-standard aspects of instrument and non-instrument units. Imagine a step sequencer for filter cutoff, or some instrument parameter that is -not- the note being played (panning, detune, mod amount, etc). There could be a path forward where a wrapper `FilterCutoffInstrument` or `FooInstrument` is created and can be articulated by the same universal InstrumentStepSequencer. It might be necessary to `@=>` assign a specific member from an instrument class into the `FooInstrument`, but in theory this should see that the InstrumentStepSequencer is generally useful as a step sequncing utility. 

## Today's outcomes
- ported forward the base step sequencer and the envelope step sequencer with minor mods 


## Lessons
- There needs to be something semantically clear for how to handle a `0` step
  - it could be considered a keyOff or could be sonsidered a sustain
  - perhaps -1 could be a note off, and 0 could be a sustain
  - this precludes using negative values to go lower than the `baseNote`
  - this precludes using a `0` value for a note of exactly the `baseNote` value
- the real issue is that you can't overload on/off and note-value into the same single-digit step
  - each step could consist of a pair (or triplet if the case presents, ex. on/off, note, velocity, pan)
  - `[[1, 32],[1, 34],[1, 35],[0, 0],]`
  - should probably write it as two arrays for readability, then write an array-zip util
- `-1` is considered truthy

