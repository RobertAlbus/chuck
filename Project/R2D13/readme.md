# R2D13

## Today's goals

### Learn about connecting inputs and outputs of UGens to more than one thing at once
- Can I? Turns out yes.

### Try to set up a simple delay feedback 
- Did it, works fine

### Extend Chugen
- how can I create classes that adhere to the conventions of the lanuage?
- I want to be able to use the `=>` operator to connect my custom class to another UGen
  - `myCustomUGen.output => dac` not good way, but I know how to do it
  - `myCustomUGen => dac` good way, but I don't know how to do it

## Today's outcomes
- Learned about routing multiple inputs and outputs for a single UGen
- Set up a delay feedback loop including a filtering step
- Split today's code off into classes and added a parallel delay chain with a different delay time

## Lessons
- I can connect a gain output to more than one other UGen's input!

