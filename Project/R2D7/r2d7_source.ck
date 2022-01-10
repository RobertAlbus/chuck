Time _time;
_time.setBpm(120);

MidiNotes _notes;
MidiScales _scales;

// SOUND NETWORK
ADSR adsr => dac;
SawOsc osc1 => adsr;
SqrOsc osc2 => adsr;

// OSC/ENV INSTRUMENTATION
0.4 => osc1.gain;
0 => osc1.freq;

0.4 => osc2.gain;
0 => osc2.freq;

0.25::_time.quat => dur A;
0.5::_time.quat => dur D;
0.7 => float S;
2::_time.quat => dur R;

adsr.set(A,D,S,R);

// STEP SEQUENCER
StepSequencerPitch stsq_p;
StepSequencerEnv stsq_e;

// STSQ INSTRUMENTATION
Osc oscs[0];
oscs << osc1 << osc2;
oscs @=> stsq_p.oscs;

Envelope envs[0];
envs << adsr;
envs @=> stsq_e.envs;

0 => stsq_p.baseNote;
[1] @=> stsq_e.steps;

_scales.dorian(_notes.Eb2) @=> stsq_p.steps;

while ( _time.currentBar() < 2) {

  if (_time.isStepStart()){
    _time.sequenceStep() => int step;
    stsq_p.play(step);
    stsq_e.play(step);
  }

  _time.advance();
}

_scales.phrygian(_notes.Eb2) @=> stsq_p.steps;

while ( _time.currentBar() >= 2 && _time.currentBar() < 4) {

  if (_time.isStepStart()){
    _time.sequenceStep() => int step;
    stsq_p.play(step);
    stsq_e.play(step);
  }

  _time.advance();
}

stsq_e.off();
stsq_p.off();
_time.advance(R);
