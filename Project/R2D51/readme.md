# R2D50

## Today's goals

### Make LFO controller
should be able to select the wave shape, including noise.
Might be worthwhile to generalize the "select wave shape" utility because that is also used in the OscSynthSingle.
Should try to figure out how to re-trigger the osc phase.


## Today's outcomes
- Created a naive LFO implementation

## Lessons / Thoughts
- might want to convert all Chugen based instruments to UgenStereo and only use Chugen for oscillator-level constructs
- could create a custom Oscillator class that abstracts the differences between standard Oscs, Noise, and my custom Chugens