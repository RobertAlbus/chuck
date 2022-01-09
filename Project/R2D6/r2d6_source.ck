Time _time;
_time.setBpm(120);

MidiNotes _n;
MidiIntervals _;

TriOsc osc => dac;
StepSequencerOsc stsq;
osc @=> stsq.osc;
0 => osc.gain;
0 => osc.freq;

[1,1,1,0,1] @=> stsq.triggerSteps;
[
  _.P1,
  _.M2,
  _.m3
] @=> stsq.pitchSteps;
[1.0] @=> stsq.velocitySteps;

_n.G3 => stsq.basePitch;
0.0 => stsq.baseVelocity;

while ( now / _time.bar < 2) {
  stsq.play(_time.sequenceStep());
  _time.advance();
}
