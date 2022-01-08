#100DaysOfCode

This is my second round for #100DaysOfCode and as such you will see the `R2` prefix on file names.

To run these files:

- install chuck if needed
- run `chuck r2d4_run.ck`
- due to an idiosyncrasy with the ChucK interpretter, you cannot import a dependency and immediately use it. All dependencies must be aggregated in one root file which does not itself have any code that relies on these dependencies. The convention is to call this `$projectName_run.ck` and often this file contains _only_ the imports.

File format follows R2D0 such that

- R2 = round 2
- D\_ = day \_\_\_
