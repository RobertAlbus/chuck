# R2D15

## Today's goals

### Wrap a delay line in a Chugen
- Do mono first
- See what I can find about stereo Chugens

## Today's outcomes
- Created mono echoer with a Chugen
- Expanded the feedback chain to include additional FX processing (for fun)

## Lessons
- Impulse UGen is next-able so I can pass my Chugen's tick() input to this one sample at a time to feed the signal chain
- I may want to control the feedback amount outside of the delay itself so that I can have additional signal processing before feeding back