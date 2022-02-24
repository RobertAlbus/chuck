# R2D52

## Today's goals

### Make automation clip
should be able to select the wave shape, including noise.
Might be worthwhile to generalize the "select wave shape" utility because that is also used in the OscSynthSingle.
Should try to figure out how to re-trigger the osc phase.


## Today's outcomes
- Added centerVal to LFO so the LFO value can be offset by a certain amount if desired
- Used the LFO on the pitch of a sine so that I could hear it in action
- Used the Envelope class to control a value over time

## Lessons / Thoughts
- LFO could use a flag for "never below zero" so it can easily and safely be used for controlling `.freq` on filters or oscillators
- Envelope class is reasonably easy to use
  - needs to be chucked to a sink (blackhole or dac)
  - might still be good to encapsulate it so I can control the API and encapsulate the sink
  - should build a step sequencer for envelopes
  - when considering the API, consider desired interaction when using it for arrangement. 
  