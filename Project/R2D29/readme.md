# R2D28

## Today's goals

### Try instantiating a MIDI controller more than once
Discover if opening an input device takes exclusive control of that device. If so, it might make sense to have a global MIDI handler. The outcome could have implications on concurrency for a multi-shred project.

### Control FilterFmFreq by ratio of main osc pitch, not by Hz
I should be able to get better pitch resolution maybe?

## Today's outcomes
- opened a MIDI device twice and logged the incoming control channel from both instances at the same time

## Lessons
- You can open the same MIDI device more than one time!