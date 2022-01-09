Time _time;
_time.setBpm(160);

TriOsc osc => dac;
0 => osc.gain;
0 => osc.freq;

StepSequencerOsc stsq;
osc @=> stsq.osc;

[1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0] @=> stsq.triggerSteps;
[0,2,3] @=> stsq.pitchSteps;
[1.0] @=> stsq.velocitySteps;

55 => stsq.baseNote;
0.0 => stsq.baseVelocity;

while ( now / _time.bar < 4) {

  if (_time.isStepStart()){
    _time.sequenceStep() => int step;

    stsq.play(step);
  }

  _time.advance();
}
