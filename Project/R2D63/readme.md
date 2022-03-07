# R2D63

## Today's goals
### Add panning to Mixer
Add integration for panning into the mixer

## Today's outcomes
- create a StereoProcessor that is the base class for StereoChannel and mixer processing classes
- create a StereoChannel class to encapsulate each channel

## Lessons / Thoughts
- All extension points (Chugen, Chubgraph, etc) are mono UGens
  - I need to create some base class that is a Chugen
  - should specify L&R inputs
  - `tick()` needs to operate on both of these, and not the `float in` arg that it accepts.
   
- matured version of the previous thought:
  - once a signal is stereo, all subsequent channels in the mixer must be stereo
  - therefore the best approach is that all channels are stereo
  - I should create a base class that defines the stereo interface (ChucK doesn't have stereo Chugens or Chugraphs)
  - base class should have `update()` function the mixer can call when `mixer.update()` is called
  - `mixer.update()` should be called every sample in the main composition engine
  - base stereo class `update()` calls `process(inL.last(), inR.last())` and this is the approximation of Chugen's `tick(input)`

