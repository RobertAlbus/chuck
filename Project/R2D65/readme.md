# R2D65

## Today's goals

### Explore some performance enhancements
- look into superfluous chuck-to-blackhole actions
- consider the frequency of checking for updates
  - pattern updates, controller updates, etc, can handle lower resolution for playback

## Today's outcomes
- Removed superfluous chuck-to-blackhole from StereoProcessor

## Lessons / Thoughts
- performance seems better
  - I am working on my laptop, which is more powerful
  - I also commented out the code to open the MIDI device
    - MIDI might be massively inefficient
    - should double check this back on my desktop computer
  


