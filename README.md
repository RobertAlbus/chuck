# #100DaysOfCode

22-01-03 => 22-04-12

This is my second round for #100DaysOfCode and as such you will see the `R2` prefix on file names. The `D5` portion signifies the day of the challenge.

To run these files:

- install chuck if needed
- there is a pulse-audio version of chuck
  - get up and running faster
  - will experience audible playback artifacts
- prefer the jack version of chuck when possible
- run `chuck r2d4_main.ck`

## Notable projects

- R2D1-R2D10
  - Step sequencer, MIDI/scale/chord utils, time utils
- R2D19
  - Nice Chugen for a delay plugin
  - ADSR controller
- R2D21
  - OscSynthSingle mementos can be serialized and deserialzed (presets)
- R2D23
  - The readme has a key insight into a modification I should make to the project architecture
  - proposes that I add a `Bedrock` layer to accomodate core utils with no dependencies. This might include string/array utils or things the language and std lib is missing
- R2D27, R2D29, R2D32
  - really cool UGen
- R2D28
  - First MIDI!
- R2D32
  - Ring Mod Ugen
- R2D33, R2D34, R2D36
  - Synthesize an 808-style hi hat
  - D34 converts from square waves to Ring Mod
  - D36 converts patch to Chugen

## Project Architecture

The repo is set up in accordance with Helix 3-layer architecture principles.

- Project
- Feature
- Foundation

### Foundation

Abstract libraries and base utilities.

A module in Foundation:

- May only depend on files Foundation/Core module
- May not depend on other Foundation modules
- May not reach up into Feature or Project modules

### Feature

Intruments and such.

A module in Feature:

- May depend on any Foundation modules
- May not depend on any other Feature modules
- May not reach up into Project modules

### Project

Actual compositions with run-able loops.

A module in Project:

- May depend on any Feature and Foundation modules
- May not depend on other Project modules
