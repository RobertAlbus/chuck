# R2D35

## Today's goals
### Model a plucked string
Create a UGen that models a plucked string. Will require an Impulse UGen, a Delay, various Gains, and a LPF.
### Create a reverb
Just try some stuff I read... Seems like the basic concept is easy but there is a lot of math if you want to do this right. 

## Today's outcomes
- Did the thing
- Created a single delay line reverb, then comped mulitple together for a delay network with misc feedback. Randomized on each program run.
- Run two complex delay networks in series

## Lessons
- One delay line for string modeling sounds good. Adding a second or third doesn't sound interesting in any way.
- Implementing a single-delay-line reverb is easy. implementing a network is easy. but it sounds like trash.
  - Might be useful for sound design, but not useful for spatial effect. I would never reach for this to create "room" or "air"
- Sound better when you increase the number of delay lines, and then run two of the multi-line arrangements in series
- Had to increase the JACK buffer but still getting xruns
