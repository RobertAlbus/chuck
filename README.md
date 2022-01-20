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
