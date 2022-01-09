# ChucK is not perfect.

## Language Quirks

- no boolean type, just truthiness
- no first class functions
  - might be able to work around it with a closure-y class definition
  - https://lists.cs.princeton.edu/pipermail/chuck-users/2020-August/008891.html
  - probably advisable to avoid this pattern
- left-to-right assignment
- atypical assignment operators

## Dependencies

- due to an idiosyncrasy with the ChucK interpretter, you cannot import a dependency and immediately use it in the same file
  - All dependencies must be aggregated in one root file which does not itself have any code that relies on these dependencies.
  - The convention is to call this `$projectName_run.ck` and often this file contains _only_ the imports.
  - the depth of nested calls Machine.add("some_dependency.ck") affects the import order... which is weird.
    - for the helix-like project architecture, I had to add an otherwise unnecessary level of Machine.add() nesting for to maintain the order of imports

https://www.mail-archive.com/search?l=chuck-users@lists.cs.princeton.edu&q=subject:%22Re%5C%3A+%5C%5Bchuck%5C-users%5C%5D+imports%5C%2Fincludes%22&o=newest&f=1
