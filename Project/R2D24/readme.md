# R2D24

## Today's goals

### Try out the Chubgraph class

- This is looks like the right thing to use for input=>output based modules
- start by validating the concept, then consider some nice multi-effects or waveshaping

### Consider APIs for polyphonic interaction

- I might want to spork a shred for each note instance, and then progress time by the specified amount
- I should probabyl watch the Kadenze tutorials on shreds/events/etc

## Today's outcomes

- literally none
- just learned about things that don't work

## Lessons

- watched the Kadenze tutorials on concurrency
  - there is an arrangement tutorial video in Kadenze that is paygated. Might've been very useful.
  - I should see if I can find it.
- loading multiple OscSynthMultis presets makes chuck choke `[chuck]: RtApiAlsa::probeDeviceOpen: unable to synchronize input and output devices.` ad inifitum
  - this is a big problem for polyphonics.
  - this happens with string presets and object presets
  - there _could maybe possibly_ be a case for setting the synth state from another instance of the same synth.
  - I don't feel like trying it right now because it's a lot of work and I am not hopeful.
- Objects don't seem to receive messages from other shreds, IE can't call keyOn() for an OscSynthMulti from another shred.
  - I would have to instantiate the object in that shred. Might be problematic for loading presets then too. idk.
  - based on the video I watched today, I think it is intended that the ugens making sound in a shred are instantiated in that shred.
  - therefore I don't think this will work for what I want the way I thought it will
  - there is an arrangement tutorial video in Kadenze that is paygated. Might've been very useful.
  - I should see if I can find it.
