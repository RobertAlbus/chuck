# R2D50

## Today's goals
### Remove the gain-toggle in favour of a single-note noteOff pattern in a step sequencer
Gain toggle can lead to clicks and unnatural sound. Using a single-note noteOff pattern allows the synth to complete the envelope for the current note.

### Explore a new dependency structure
There are a lot of lib files in use at this point. I want to organize them better, but am hesitant to add to Foundation and Feature. Refactoring and intellisense support for ChucK is really lacking. If I want to refactors something in Foundation/Feature, I might break existing Projects. 

I plan to sort the libs in this Project into subfolders. This way I can refactor lib files and explore alternative project architectures while keeping my decisions sandboxed to the current Project.

## Today's outcomes
- 

## Lessons / Thoughts
- I should've focused on sandboxing my decisions into Projects from the beginning.
  - Foundation and Feature layers focused on code re-use and deduplication, but that wasn't the correct thing to focus on so early in my ChucK learning.
  - Projects are meant to be a snapshot in time without having to heavily rely on Git tags and branchs
  - copying files forward from previous projects has proven to be a great way to refine