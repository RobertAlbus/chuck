Time _time;
_time.setBpm(60);

MidiNotes _notes;
MidiScales _scales;
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
  // add same pattern for each envelope step sequencer
  [1] @=> stsq_e.steps;
}

////////
// CHORDS

_scales.dorian(_notes.Eb3) @=> int scale[];
scale.popBack(); // remove the octave so that we can wrap around the scale for the next note appropriately

[ 0, 0, 0, 0 ]             @=> int O[];
_lib.makeSeventh(scale, 0) @=> int I[];
_lib.makeSeventh(scale, 1) @=> int II[];
_lib.makeSeventh(scale, 2) @=> int III[];
_lib.makeSeventh(scale, 3) @=> int IV[];
_lib.makeSeventh(scale, 4) @=> int V[];
_lib.makeSeventh(scale, 5) @=> int VI[];
_lib.makeSeventh(scale, 6) @=> int VII[];

int chords[0][0];
chords << I << O << VI << II << V << I << VI << V << VII;
_lib.rotateMatrix(chords) @=> chords;

// Attach chords to pitch step sequencers
for (0 => int i; i < chords.size(); i++){
  chords[i] @=> stsqs_p[i].steps;
}

_time.currentUnit(_time.bar) => int currentBar;
while ( currentBar >= 0 && currentBar < 2) {

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

// REPEAT THE FIRST CHORD ONE LAST TIME
for (0 => int i; i < stsqs_p.size(); i++){
  stsqs_p[i].play(0);
  stsqs_e[i].play(0);
}
_time.advance(_time.quat);
_time.advance(_time.quat);

// CLOSE OUT
for (0 => int i; i < stsqs_p.size(); i++){
  stsqs_p[i].off();
  stsqs_e[i].off();
}
_time.advance(R);
