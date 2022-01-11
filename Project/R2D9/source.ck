Time _time;
_time.setBpm(60);

LibR2D8 _lib;

////////
// SOUND NETWORK
SqrOsc osc1;
SqrOsc osc2;
SqrOsc osc3;
SqrOsc osc4;
Osc oscs[0];
oscs << osc1 << osc2 << osc3 << osc4;
ADSR adsr1;
ADSR adsr2;
ADSR adsr3;
ADSR adsr4;
Envelope envs[0];
envs << adsr1 << adsr2 << adsr3 << adsr4;
Gain master => dac;
0.4 => master.gain;

////////
// ENVELOPE TIMING
0.5::_time.quat => dur A;
0.75::_time.quat => dur D;
0.6 => float S;
0.5::_time.quat => dur R;

for (0 => int i; i < oscs.size(); i++) {
  envs[i] $ ADSR @=> ADSR env;
  oscs[i] @=> Osc oscillator;
  oscillator => env;
  0.1 => oscillator.gain;
  0   => oscillator.freq;
  
  env => master;
  env.set(A,D,S,R);
}

////////
// STEP SEQUENCER INIT
StepSequencerPitch stsq_p1;
StepSequencerPitch stsq_p2;
StepSequencerPitch stsq_p3;
StepSequencerPitch stsq_p4;
StepSequencerPitch stsqs_p[0];
stsqs_p << stsq_p1 << stsq_p2 << stsq_p3 << stsq_p4;

StepSequencerEnv stsq_e1;
StepSequencerEnv stsq_e2;
StepSequencerEnv stsq_e3;
StepSequencerEnv stsq_e4;
StepSequencerEnv stsqs_e[0];
stsqs_e << stsq_e1 << stsq_e2 << stsq_e3 << stsq_e4 ;

// LINK TO STSQ
for (0 => int i; i < stsqs_p.size(); i++){
  oscs[i]            @=> Osc      oscillator;
  envs[i] $ Envelope @=> Envelope envelope;
  stsqs_p[i] @=> StepSequencerPitch stsq_p;
  stsqs_e[i] @=> StepSequencerEnv   stsq_e;

  // Attach oscs to pitch step sequencers
  [oscillator] @=> stsq_p.oscs;
  // do not transpose
  0 => stsq_p.baseNote;

  // Attach envelopes to envelope step sequencer
  [envelope] @=> stsq_e.envs;
}

////////
// CHORDS

// x: time, y: pitch
int chords[0][0];
_lib.getChords() @=> chords;

////////
// STEPS
for (0 => int i; i < chords.size(); i++){
  chords[i] @=> stsqs_p[i].steps;
  chords[i] @=> stsqs_e[i].steps;
}

_time.currentUnit(_time.bar) => int currentBar;
while ( currentBar >= 0 && currentBar < 4) {

  if (_time.isStartOfUnit(_time.quat)){
    _time.currentUnit(_time.quat) => int step;

    for (0 => int i; i < stsqs_p.size(); i++){
      stsqs_p[i].play(step);
      stsqs_e[i].play(step);
    }
  }

  _time.currentUnit(_time.bar) => currentBar;
  _time.advance();
}

// CLOSE OUT
for (0 => int i; i < stsqs_p.size(); i++){
  stsqs_p[i].off();
  stsqs_e[i].off();
}
_time.advance(R);
