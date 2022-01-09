Time time;
time.setBpm(120);

TriOsc osc => dac;
StepSequencerOsc stsq;
osc @=> stsq.osc;
0 => osc.gain;
0 => osc.freq;

[1,1,1,0,1,0] @=> stsq.triggerSteps;
[0,2,3] @=> stsq.pitchSteps;
[1.0] @=> stsq.velocitySteps;

55 => stsq.basePitch;
0.0 => stsq.baseVelocity;

while ( now / time.bar < 2) {
  stsq.play(time.sequenceStep());
  time.advance();
}
