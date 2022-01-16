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
- I need to pipe input into a Chugen for the tick function to receive a non-zero value
- Clearly I need to learn some maths for DSP now
