# R2D15

## Today's goals

### Wrap a delay line in a Chugen
- Do mono first
- See what I can find about stereo Chugens

## Today's outcomes
- Created mono echoer with a Chugen
- Expanded the feedback chain to include additional FX processing (for fun)
- Created a SingleOscSynth to prove out the idea of creating a dynamic version of ImageLine's 3xOsc (one of my faves!)

## Lessons
- Impulse UGen is next-able so I can pass my Chugen's tick() input to this one sample at a time to feed the signal chain
- I may want to control the feedback amount outside of the delay itself so that I can have additional signal processing before feeding back
- There is probably a case for encapsulating ADSR and LFO control signals as a class
- There is probably a case for creating an abstraction that encapsultates a filter (including ADSR and LFO)