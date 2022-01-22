# R2D16

## Today's goals

### Find a better solution to mementoization
A memento that has class props has to be serialized and deserialized in a bespoke way. If I use an associative array and stringify all values then I should be able to serialize programmatically. I could in theory take this a step further and also store all props on the memento-able class in an associative array.  

## Today's outcomes
- Created a programmatic memento implementation in OscSynthMemento
- overdrove the master channel output and it sounds really good

## Lessons
- the memento class could probably be universal since all synth props are stringified and stored in an associative array
- I have to map the memento to class props for the memento-able class (I could take the same associative-array approach as the Memento class but I'm worried that might chew CPU when done 44.1k/second for each accessed prop on every single synth instance)
- naive implementation of the memento would've meant waaay more code, and a memento class for each memento-able class. that would quickly spiral out of control.
- tried using a Chugin but I think I have to install additional software or recompile Chuck to use them
