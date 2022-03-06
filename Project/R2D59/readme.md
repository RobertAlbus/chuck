# R2D59

## Today's goals
### Try making a mixer
Explore how I might like to make that

## Today's outcomes
- Sketched out the shape of a mixer class

## Lessons / Thoughts
- I only need to be concerned with setting up channels and routing, not with changing, rerouting, tearing it down
- this is because my only goal is to compose, not live code

- I might want to connect a channel to another when I create it.
- overall I should probably try this mixer out and see what I think of the API.

- sends are designed post-gain currently. might be great to have a pregain option?

- I need processing classes to update
- currently they aren't Chugens so there's no way to tie eg. LFO to a param of the processing class.
  - I could make the mixer and the processing into Chugens
  - could also just add an `update()` method and make sure to call it in the main composition engine loop.
    - this only works with an update loop of 1 sample in length.
    - I will try this first