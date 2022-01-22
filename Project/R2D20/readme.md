# R2D20

## Today's goals

### Parse a preset string into an associative array
Convert a string such as 
```
;gain=0.5000;cutoff=200.0000;name=Ruthless;for=OscSynthSingle;
```
into an associative array.


## Today's outcomes
- wrote POC code for that thing

## Lessons
- ChucK really is missing a lot of useful methods.
- I don't think I can add methods to the string class either, so the subject of the call itself is always an argument to the call. would rather have `myString.split(" ")` rather than `split(myString, " ")`