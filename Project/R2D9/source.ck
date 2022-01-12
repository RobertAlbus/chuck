Time _time;
_time.setBpm(80);

MidiNotes _notes;
MidiScales _scales;
LibR2D9 _lib;

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

_notes.Eb3 => int note;
_scales.heptoniaPrima @=> int toneSpace[];
_scales.generateMode(1, note, toneSpace) @=> int scale1[];
_scales.generateMode(3, note-4, toneSpace) @=> int scale2[];

// x: time, y: pitch
int chordProgression1[0][0];
_lib.getChords(scale1) @=> chordProgression1;
int chordProgression2[0][0];
_lib.getChords(scale2) @=> chordProgression2;


0 => int sectionA_start;
2 => int sectionA_end;
sectionA_end => int sectionB_start;
4 => int sectionB_end;

_lib.setSteps(stsqs_p, stsqs_e, chordProgression1);
_time.currentUnit(_time.bar) => int currentBar;

fun int isFinalSampleOf(dur duration){
  duration / samp => float durationSamples;
  durationSamples - 1 => float finalSample;
  
  now / samp => float currentSample;
  return currentSample == finalSample;
}

while ( currentBar >= sectionA_start && currentBar < sectionA_end) {

  if (_time.isStartOfUnit(_time.quat)){
    _time.currentUnit(_time.quat) => int step;

    for (0 => int i; i < stsqs_p.size(); i++){
      stsqs_p[i].play(step);
      stsqs_e[i].play(step);
    }
  }

  _time.currentUnit(_time.bar) => currentBar;
  if (isFinalSampleOf(sectionA_end::_time.bar)) {
    _lib.setSteps(stsqs_p, stsqs_e, chordProgression2);
  }
  _time.advance();
}

while ( currentBar >= sectionB_start && currentBar < sectionB_end) {

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
