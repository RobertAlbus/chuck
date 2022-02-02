# R2D30

## Today's goals

### Make a fun UGen
Just want to play some more

### explore MIDI further
If I can figure out how to use the KX Studio XY and Keyboard controller then perhaps Ic an see if my physical controller is not reliably sending note-off signals (or if it's actually ChucK's fault).


## Today's outcomes
- I tried using the realtime kernel to see if it had any effect on receiving the missing MIDI note-off signals. It did not.
- I guess it's the MIDI controller itself actually. See lessons section.
- MIDI is a fuck, want to make GUIs.

## Lessons
- Can use cadence-xycontroller with chuck
  - install `a2jmidid`
  - run `a2jmidid -e`
  - use Catia to link the XY Controller to midi-through
- My hardware MIDI contoller (M-Audio Axiom Air Mini 32)
  - IS NOT reliably sending note-on and note-off signals for monophonic key articulation
  - IS reliably sending note-on and note-off signals for polyphonic key articulation
- Cadence XY Controller sends the correct note-on-off signals