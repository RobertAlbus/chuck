# R2D21

## Today's goals

### Create a Preset class that any synth or effect can use
- use D17-D20 code to create a synth that can have it's preset serialized and unserialized
- this should be facilitated by a Preset class that is just a skin over an associative array (using what was learned on D20)

### Try out the Chubgraph class
- I think this is what I need to use for Chugens with an input, such as R2D19's echo effect
- it has `inlet` and `outlet` property
- this should mean that we don't have to push the incoming tick value onto a Step or Impulse


## Today's outcomes
- 

## Lessons
- There is probably a case for a ListStore to compliment the KeyValueStore. This would hold a list of homogenous items whose order and key do not matter. This would be useful for OscSynthMulti wherein the preset consists multiple unordered sets of OscSynthSingle Presets
- the substring() function apparently mutates the object it's called on, rather than returning a new string. WHAT WHY!?