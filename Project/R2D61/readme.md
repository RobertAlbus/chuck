# R2D61

## Today's goals
### Explore the mixer pattern further
Make the `update()` function not bork.

## Today's outcomes
- fixed bug in Mixer
- removed auto-scaling gain levels

## Lessons / Thoughts
- massive DC offset, ranging from +1 to +60
- should not autoscale the buses.
- seems like there might some memory addressing error in Chuck when using the `string keys[0]` key list for programmatic access to dynamic arrays. 
  - I can see that I am assigning the right gain to the channelIn when I log in the `createChannel()` function
  - when I try to get the channel later and read the gain, they all say `1.00` instead of the vale previously set to gain.
  - JK, I had `@=>` where I meant to use `=>` to _connect_ two entities, but I instead reassigned the latter with the former.
  - DAMN OVERLOADED CHUCK OPERATORS. I NEVER LIKED THEM, THIS IS PROOF WHY THEY ARE BAD.

Turns out I was re-assigning the input to the output on every channel i `createChannel(string channelName, float gain)`, instead of connecting them and that was my bug.

