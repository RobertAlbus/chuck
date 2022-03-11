# R2D66

## Today's goals

### Convert MIDI-controlled params to automation clips
just what it sounds like.

## Today's outcomes
- Added simple automation clip to 16 measure composition

## Lessons / Thoughts
- should refactor automation clip
  - should only specify `value` at `time`
  - automation clip should interpolate change-duration based on this+next automation point
  - will have to capture special case: last value of the array doesn't have a "next" valueetting there.
- now experiencing performance bottlenecks

