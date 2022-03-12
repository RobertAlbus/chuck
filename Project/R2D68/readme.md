# R2D68

## Today's goals

### Remove change-rate from automation clip pattern

## Today's outcomes
- refactor automation clip to prevent full-table lookup every $timeUnit

## Lessons / Thoughts
- I hadn't considered how to handle two automation points at the same point in time
  - I have to just trust the order of them I guess!
  - wait, I can't. It's borks the index placement. cannot have 2 items at `list[i]`
  - input data format could be `[time, value]` and `[time, value, jump-value]`
  - output data format could be `[0 or empty]`, `[nextValue, changerate]` and `[jumpValue, nextValue, changerate]`
- getting null reference or index out of bounds errors at tail end of composition
  - goes away if I spam NoOp automation points into the end of the automation clip
  - seems like it has to do with the composition tail-time to let sounds finish