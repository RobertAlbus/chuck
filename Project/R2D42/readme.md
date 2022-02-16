# R2D42

## Today's goals
### continue to explore the step sequencer pattern
It makes sense that this should overall adhere to the instrument interface.
I want to have steps for both the note value and for the on/off/sus trigger state

## Today's outcomes
- Created. 

## Lessons
- all instruments need `keyOn` with and without a note val, `note` that changes note value without trigger the envelope, and `keyOff`