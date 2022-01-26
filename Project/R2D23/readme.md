# R2D23

## Today's goals

### Move solidified libs to Foundation

The string utils, ADSR controller, and key/value store seem like they are probably stable and won't see breaking changes for a good while (if ever)

### Ponder the following
- Try out the Chubgraph class
  - This is looks like the right thing to use for input=>output based modules
- Consider APIs for polyphonic interaction
  - I might want to spork a shred for each note instance, and then progress time in the shred by the specified amount
  - I should probably watch the Kadenze tutorials on shreds/events/etc

## Today's outcomes
- Moved some lib files to Foundation
- Added semitune and cent tuning to OscSynthMulti

## Lessons
- I think the proper architecture split is `Bedrock/Foundation/Feature/Project`. This adds a `Bedrock` layer for the dependency-less module that would previously be found in `Foundation`.
- The original Helix architecture was initially designed for the Sitecore CMS, which runs on the .NET runtime. The C# language is robust and has a lot of useful utilities that the Chuck language simply does not have. Since I have to write these myself it makes sense to accomodate them with a revision to the architecture.
- I don't have to take care of that today.
