# R2D67

## Today's goals

### Route synths into mixer
patch the synths into the mixer. Any processing that is defined should be moved to the mixer channel's Processing class if possible

## Today's outcomes
- route intruments through the mixer

## Lessons / Thoughts
- need to figure out multi-channel output for `WvOut`
- I think the arrangement and automation clip both consume a lot of CPU cycles
  - the step sequencer always gets step N based on playback position
  - the non-step based sequencers are doing a lookup through the whole value array every time
  - should transform the non-step array into a uniform step array
  - how would this work if I upgraded automation clip to *infer* the change rate duration based on the *next value*?
    - I would have to skip over the no-op steps until I find an op-step
    - or I could interpolate the value for each step
    - overall this would be a huge piece of work I think

