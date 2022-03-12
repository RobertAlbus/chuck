# TODO
## Instrument vs. Generator refactor
- make `Instrument` extend `Chugraph`
  - any current `Instrument` subclasses that require `tick()` should probably extend `Generator extends Chugen` and then use that inside of the `Insturment`
  - `Generator` is to `Chugen` as `Instrument` is to `Chugraph`
    - `Generator` should have a `retrig()` function to retrigger the oscs and LFOs
- add osc phase retrigger to instruments

## composition scores
- Consider making the composition score an aggregate of multiple instrument-pattern-scores
  - this prevents a custom-per-composition score format
  - should help generalize the transforms used in any-period-to-fixed-period functions
- read notes in R2D68

---- DID THIS!
- Transform `AutomationClip` scores
  - full-composition scores are onerous to write if you have to write *every* time unit even when there is no change
  - this is not the case for short patterns in step sequencers
  - full composition-length patterns should be transformed into fixed-period step sequence from any-period sequence
  - this prevents many conditionals in the main composition loop
- refactor:
  - should only specify `value` at `time`
  - automation clip should interpolate change-duration based on this+next automation point
  - figure out this duration before transforming into the format specified above
  - will have to capture special case: last value of the array doesn't have a "next" value.
----
- just need to fix the null reference / index out of bounds error at the end of the composition per R2D68 readme notes


## controllers
- base class for controllers (perhaps)
- LFO but noise (separate tool)
  - min, max, range, center value (just like LFO)

# other
- velocity
  - copy constructor (instruments and generators)
    - this would be useful for creating additional voices when implementing velocity
- automation clip LOOPS