# R2D38

## Today's goals
### Explore typecasting
I want to see if I can treat objects the same even without sharing inheritance chains or something.

## Today's outcomes


## Lessons
An object must inhererit (directly or indirectly) from the type to which you are trying to cast.

Strangely, the keyword `implements` is picked up by the ChucK syntax highlighting.


certain keywords are picked up by the ChucK syntax highlighter but don't seem to do anything
- `implements`: 
  - it doesn't seem to be doing anything
  - it also doesn't throw an error though, which I expect it would.
- `interface`:
  - can declare an interface (but not use it?)
  - When putting a method signature and body in the interface, compiler complains that you can't have code in an interface
  - when removing the method body from the interface, the compliler complains that you can't have a code-less function `function declaration must contain code... (unless in interface, or is declared 'pure')`

