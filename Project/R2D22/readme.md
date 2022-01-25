# R2D22

## Today's goals

### Combine multiple OscSynthSingle presets
My OscSynthMulti class is an aggregate of OscSynthSingles. The child items can read and write presets, so I need to manage to do this for the parent aggregator.

### Try out the Chubgraph class

- I think this is what I need to use for Chugens with an input, such as R2D19's echo effect
- it has `inlet` and `outlet` property
- this should mean that we don't have to push the incoming tick value onto a Step or Impulse

## Today's outcomes
- added existing patch and default patch to the OscSynthSingle preset class
- built the preset de/serialization for OscSynthMulti
- didn't get around to touching Chubgraph

## Lessons
- there are function in the Std namespace that I should be using for value conversion when serializing
- need setter and getter that take ints as keys in KeyValueStore, then uses the stringified int as a key in the conventional K:V strategy
