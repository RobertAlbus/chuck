# R2D11

## Today's goals

### Control a filter's cutoff frequency with an ADSR envelope
Yesterday I saw the Step UGen in action. It will hold a value provided to the member `next` until it receives another `next`ed value. I should be able to use this to perform some math to create a control signal for a filter cutoff.

## Today's outcomes
- controlled a filter cuttoff frequency with an ADSR
- tried adding a HPF at 10/20/30 hz to remove the artifacts that happen when the filter cutoff approaches 0hz but it resulted in super wacky audible artifacts
- expanded the project to include a kick drum by applying the ADSR strategy to the kickdrum.freq

## Lessons
- Step UGen is going to be useful for control signals going forward
- should use a Gain UGen piped to blackhole as the destination for the results of control-signal utilities
- update FIlter.freq with Gain.last() every sample (in today's case I also performed arithmetic to define an operational range for the filter)
- Apparently the value of Step is slightly increasing each time there is an evelope trigger... or something. Not sure what is going on there but I hope to find out.
