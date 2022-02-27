# R2D56

## Today's goals

### Waveform Selector utility class
Turn OscSynthSingle's waveform selector into a stand-alone utility

## Today's outcomes
- created UGenPicker class
  - dialed back the scope to just OscPicker
- Add OscPicker to LFO

## Lessons / Thoughts
- yesterday's automation clip is great, but the time constraint sucks
  - can only specify time fractions that satisfy `2^-N` where N is a natural number
  - I need to come up with a decent composition methodogy (leveraging variable naming) to constrain values in an easy to read/write format
- I should wrap Oscs and Noise in a class to unify the APIs
  - UGenPicker should then return this class
  - Noise directly subclasses UGen
  - various Oscs subclass Osc, which in turn subclasses UGen
  - calling `.freq(...)` on Noise should just transparently do nothing, but will currently crash the composition
  - guess I could create a NoiseLfoController as a seperate class!!
  - BIG IMPORTANT NOTE
  - trying to step through this, there is more to figure out that I have brame right now
  - just add bespoke noise mode to LFO!
- I should consider if I want my LFO to track member variables for
  - min and max lfo values
  - center and range values
  - min and range
  - these each offer different options for meta-control
  - there might be an approach to explore where::
    - assigner functions for each param, run calculations and reassign member variables
    - it is unlikely to use multiple paradigms on the same LFO
    - but would use multiple paradigms on different LFOs in one composition