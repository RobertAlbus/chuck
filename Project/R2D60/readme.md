# R2D60

## Today's goals
### Explore the mixer pattern further
Created a naive Mixer implementation. I need to have sample-level updates of the mixer channel processing classes similar to a Chugen. I dont think a Chugen is needed because I would have to take the `tick()` input and internally route it to the processing inlet, then the reverse for the output. I think I can create a simple `update()` function and call it from `Mixer.update()` every sampple in the main engine loop. This is viable because I simply need to update things like controller automations and their targets. 

## Today's outcomes
- create a superclass Processing that processing classes should inherit

## Lessons / Thoughts
- 