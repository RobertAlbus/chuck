# R2D13

## Today's goals

### Extend UGen and play with tick() function
- just play with it and see what I can learn

### Can I encapsulate a signal chain within a chugen?
- I am wondering how I can take the input to my Chugen and pipe it to an internal arbitrary Ugen.
- If I can do this, I could create an echo processor

## Today's outcomes
- Created a class that extends Ugen, then Chugen

## Lessons
- UGen doesn't automatically tick() but Chugen does
- All UGens need to be piped somewhere. use black hole if you want to sink it.
- I can pipe input to a chugen and that sample's value will be the float that is passed as an arg to tick()
- Would be good to learn some maths for DSP now
- This will be useful for wrapping up constructs such as multi-osc synths, delay lines, mixer
