# R2D50

## Today's goals

### Integrate new utils into R2D50 file structure
* R2D50 implements a potential repo structure
* Initial repo structure I chose did not end up suiting the class hierarchies
* When creating R2D50 I sandboxed my decisions about the new lib structure inside R2D50
* This allows one to not worry about breaking compatibility for previous project with later refactors
* I made more utilities in the past week and I want to add them to this library structure

## Today's outcomes
- Added the past weeks utilities to the composition from R2D50

## Lessons / Thoughts
- `CTRL + L|R` doesn't stop at underscores, but does stop at dashes
- should convert file names to use dashes
- layer hierarchy seems like it should be:
  - core
  - founation
  - instrument
  - pattern??
  - arrangement??
- there must be some pattern for a generic base step sequencer
  - I want a step sequencer for Instruments               (instrument signals)
  - I want a step sequencer for AutomationEnvelope values (control signals)
  - I want a step sequencer for probably other things???
  
