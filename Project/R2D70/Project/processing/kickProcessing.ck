public class KickProcessing extends StereoProcessor {
  patchThrough();

  // should create a mixer send for sidechain aggregation
  // SIDECHAIN DOES NOT SEEM TO WORK!

  StereoChannel sidechainSource;
  inL => sidechainSource.inL;
  inL => sidechainSource.inR;

  fun void update() {}
}