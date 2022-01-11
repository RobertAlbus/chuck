# R2D9

## Today's goals

### explore a new pattern for the shape of Project modules

I want to experiment with library patterns on a per-project basis rather than immediately trying to create library code in Foundation and Feature layers. This way I can make sure that a pattern is sound before I create it as a repo-wide dependency.

### explore an imperative method for setting up a polyphonic sequence

In light of the above, I want to find a way to set up polyphonic playback for a chord progression. I want to experiment with a couple different declarative approaches once I've seen how to do this imperatively.

## Today's outcomes

- created new Project Module architecture
  - cloned yesterday's Project forward
  - converted that code to a multi-file Project architecture
  - explored imperative method for creating chord progressions
  - explored declarative method for creating chord progressions in `lib.ck`
- added a groovy pattern to the chord progression
  - using pitch data as envelope trigger data
  - no pitch, no envelope trigger
  - works great
- created a key modulation that doesn't sound like butts!

## Learned

- I need to rotate my chords object (int[][]) from sequence-based to temporal-based for my current polyphony implementation
  - probably don't need to do this if I have a PolyphonicOsc implementation
- this new architecture is a great idea
  - I can sketch through ideas without having to constantly refactor my core libs as learn more
  - It should reduce the frequency of broken Projects because because it's library code is frozen in time
  - once I am comfortable with a pattern I can build a Feature Module or Foundation Module for it
