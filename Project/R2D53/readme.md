# R2D53

## Today's goals

### Automation Clip: try out an approach to declarative arrangement
Attempt to drive the envelope from a list of instructions

## Today's outcomes
- drove the envelope from a list of instructions
- added rate-of-change to instruction list

## Lessons / Thoughts
- I would benefit from having both composition-level and sequencer-level automation clips. 
  - composition-level automation would be like-length automation clips in a DAW
  - sequencer-level automation would be great for looping patterns
  - the highest ROI creation right now would be the full-composition automation clips
- rate of change has to be converted from dur to float for array-type purposes
- after further consideration, encapsulating the Envelope in an AutomationClip class is the right move one hundo