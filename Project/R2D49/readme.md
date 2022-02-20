# R2D45

## Today's goals
### Remove the gain-toggle in favour of a single-note noteOff pattern in a step sequencer
Gain toggle can lead to clicks and unnatural sound. Using a single-note noteOff pattern allows the synth to complete the envelope for the current note.

### Consider how to reduce verbosity
Some areas of the code are very verbose and ther emight be a way to reduce that
- capturing midi values for pattern changes
- step sequencer patterns
- assignment/initialization of step sequencer patterns 
- There might be a way to aggregate the patterns, midi pattern toggle, step sequencer, and instrument all in one meta handler class


- preset assigner functions

## Today's outcomes
- move step sequencer patterns into their own class

## Lessons / Thoughts
- the pattern aggregator class is intended to be an "implement once per composition" class, rather than a generalized reusable class. 