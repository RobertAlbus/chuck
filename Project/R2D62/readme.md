# R2D62

## Today's goals
### Add mute to Mixer
Add integration for mute and solo into the mixer

## Today's outcomes
- Create mute and solo functionality for the Mixer

## Lessons / Thoughts
- a Channel might benefit from being subclassed and aggregated in the Mixer.
  - It would be a good deal of extra work to implement
  - probably minimal benefit to the API
  - might be easier to reason about when reading code
  - should probably not bother until I run into problems with the mixer later.
- need to do something to confirm stereo