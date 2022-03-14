public class BassBusProcessing extends StereoProcessor {
  Time2 _time;
  inL => Dyno sidechainL => outL;
  inR => Dyno sidechainR => outR;

  [sidechainL, sidechainR] @=> Dyno sidechains[];
  for (0 => int i; i < sidechains.size(); i++) {
    20 => sidechains[i].slopeAbove;
    0.5 => sidechains[i].thresh;
    0.5::_time.beat => sidechains[i].releaseTime;
    015::ms => sidechains[i].attackTime;
    1 => sidechains[i].externalSideInput;
  }

  // should create a mixer send for sidechain aggregation
  // SIDECHAIN DOES NOT SEEM TO WORK!
  StereoChannel sidechainReceive;
  inL => sidechainReceive.inL;
  inR => sidechainReceive.inR;

  1.1 => sidechainReceive.inL.gain;
  1.1 => sidechainReceive.inR.gain;

  sidechainReceive.outL => blackhole;
  sidechainReceive.outR => blackhole;


  fun void update() {
    sidechainL.sideInput(Math.fabs(sidechainReceive.outL.last()));
    sidechainR.sideInput(Math.fabs(sidechainReceive.outR.last()));
  }
}