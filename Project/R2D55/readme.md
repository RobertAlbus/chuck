# R2D55

## Today's goals

### Create an Envelope Player of sorts
Encapsulate the Envelope and the automation pattern into one metaclass to simplify the useage in a composition.

## Today's outcomes
- Created AutomationClip
  - automatically determines the update frequency

## Lessons / Thoughts
- the auto-update-frequency detection only works with decimals where
  - `2^-N` where N is a natural number
