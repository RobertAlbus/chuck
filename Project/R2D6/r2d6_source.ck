Time _time;
_time.setBpm(120);

MidiNotes _n;
MidiIntervals _;

TriOsc osc => ADSR adsr => dac;

0.25::_time.quat => dur A;
0.5::_time.quat => dur D;
1.0 => float S;
2::_time.quat => dur R;

adsr.set(A,D,S,R);

0.4 => osc.gain;
0 => osc.freq;

StepSequencerEnv stsq_env;
StepSequencerPitch stsq_pitch;
adsr @=> stsq_env.env;
osc  @=> stsq_pitch.osc;

[1,1,1,0,1] @=> stsq_env.steps;
[
  _.P1,
  _.M2,
  _.m3
] @=> stsq_pitch.steps;

_n.G3 => stsq_pitch.baseNote;

while ( now / _time.bar < 4) {
  _time.sequenceStep() => int step;

  stsq_env.play(step);
  stsq_pitch.play(step);

  _time.advance();
}
