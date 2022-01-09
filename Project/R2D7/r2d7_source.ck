Time _time;
_time.setBpm(120);

MidiNotes _notes;
MidiScales _scales;

// SOUND NETWORK
TriOsc osc => ADSR adsr => dac;

// OSC/ENV INSTRUMENTATION
0.4 => osc.gain;
0 => osc.freq;

0.25::_time.quat => dur A;
0.5::_time.quat => dur D;
0.7 => float S;
2::_time.quat => dur R;

adsr.set(A,D,S,R);

// STEP SEQUENCER
StepSequencerPitch stsq_p;
StepSequencerEnv stsq_e;

// STSQ INSTRUMENTATION
osc  @=> stsq_p.osc;
adsr @=> stsq_e.env;

_scales.dorian(_notes.D2) @=> stsq_p.steps;
0 => stsq_p.baseNote;
[1] @=> stsq_e.steps;

while ( now / _time.bar < 2) {

  if (_time.isStepStart()){
    _time.sequenceStep() => int step;
    stsq_p.play(step);
    stsq_e.play(step);
  }
  _time.advance();
}
stsq_e.end();
stsq_p.end();

_time.advance(_time.beat);

