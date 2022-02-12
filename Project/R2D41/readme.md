# R2D40

## Today's goals
### Look into Stereo Chugens/Chubgraphs/etc
Would be great to have stereo-capable synthesizers. It will be interesting down the road to figure out panning (mono and stereo sources), width control, etc.

### Create an InstrumentStepSequencer
There are naive step sequencer implementations in the Foundation layer. Having a universal step sequencer that can operate on any instrument seems like a great idea. 

Down the road, it might be nice to use a step sequencer to control non-standard aspects of instrument and non-instrument units. Imagine a step sequencer for filter cutoff, or some instrument parameter that is -not- the note being played (panning, detune, mod amount, etc). There could be a path forward where a wrapper `FilterCutoffInstrument` or `FooInstrument` is created and can be articulated by the same universal InstrumentStepSequencer. It might be necessary to `@=>` assign a specific member from an instrument class into the `FooInstrument`, but in theory this should see that the InstrumentStepSequencer is generally useful as a step sequncing utility. 

## Today's outcomes
- 


## Lessons
- 

