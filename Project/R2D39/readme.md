# R2D39

## Today's goals
### Try adding a smoothing operation to the output of a UGen
Just an idea... What would it sound like if
- track the previous sample
- return the current sample if it is within N distance of the previous 
- else, return the min/max possible value depending on the direction of the current sample

## Today's outcomes
- implemented that idea


## Lessons
- there are changes in the spectrum
- I expected it to potentiall sound like a hpf or lpf, but it doesn't.
- smoothing allowances less than 0.05 start introducing DC offset and the volume seems to be quieter.

