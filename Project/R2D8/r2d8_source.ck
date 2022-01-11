Time _time;
_time.setBpm(60);

MidiNotes _notes;
MidiScales _scales;

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
StepSequencerPitch stsqs_pitch[0];
stsqs_pitch << stsq_p1 << stsq_p2 << stsq_p3 << stsq_p4;
StepSequencerEnv stsq_e;

// LINK TO STSQ
for (0 => int i; i < stsqs_pitch.size(); i++){
  oscs[i] @=> Osc oscillator;
  stsqs_pitch[i] @=> StepSequencerPitch stsq;
  // Attach oscs to pitch step sequencers
  [oscillator] @=> stsq.oscs;
  // DO NOT TRANSPOSE
  0 => stsq.baseNote;
}
envs @=> stsq_e.envs;
[1] @=> stsq_e.steps;

////////
// CHORDS

fun int[] makeSeventh(int scale[], int start) {
  int chord[4];
  for(0=>int i; i < 4; i++ ){
    (start + (i * 2)) % scale.size() => int noteIndex;
    scale[noteIndex] => chord[i];
  }
  return chord;
}

fun int[][] rotateMatrix(int chords [][]) {
  chords.size() => int numChords;
  chords[0].size() => int chordSize;

  int polyphonicMatrix[chordSize][numChords];
  
  for (0 => int i; i < numChords; i++){
    for (0 => int j; j < chordSize; j++){
      chords[i][j] => polyphonicMatrix[j][i];
    }
  }
  return polyphonicMatrix;
}

_scales.dorian(_notes.Eb3) @=> int scale[];
scale.popBack(); // remove the octave so that we can wrap around the scale for the next note appropriately

makeSeventh(scale, 0) @=> int I[];
makeSeventh(scale, 1) @=> int II[];
makeSeventh(scale, 2) @=> int III[];
makeSeventh(scale, 3) @=> int IV[];
makeSeventh(scale, 4) @=> int V[];
makeSeventh(scale, 5) @=> int VI[];
makeSeventh(scale, 6) @=> int VII[];

int chords[0][0];
chords << I << VI << II << V << I << VI << V << VII;

<<< chords.size(), chords[0].size() >>>;
for (0 => int i; i < chords.size(); i++){
  <<< chords[i][0], chords[i][1], chords[i][2], chords[i][3] >>>;
}
rotateMatrix(chords) @=> chords;
<<< chords.size(), chords[0].size() >>>;
for (0 => int i; i < chords.size(); i++){
  <<< chords[i][0], chords[i][1], chords[i][2] >>>;
}

// Attach chords to pitch step sequencers
for (0 => int i; i < chords.size(); i++){
  chords[i] @=> stsqs_pitch[i].steps;
}

_time.currentUnit(_time.bar) => int currentBar;
while ( currentBar >= 0 && currentBar < 2) {

  if (_time.isStartOfUnit(_time.quat)){
    _time.currentUnit(_time.quat) => int step;

    for (0 => int i; i < stsqs_pitch.size(); i++){
      stsqs_pitch[i].play(step);
    }

    stsq_e.play(step);
  }

  _time.currentUnit(_time.bar) => currentBar;
  _time.advance();
}

// REPEAT THE FIRST CHORD ONE LAST TIME
for (0 => int i; i < stsqs_pitch.size(); i++){
  stsqs_pitch[i].play(0);
}
stsq_e.play(0);
_time.advance(_time.quat);
_time.advance(_time.quat);

// CLOSE OUT
stsq_e.off();
for (0 => int i; i < stsqs_pitch.size(); i++){
  stsqs_pitch[i].off();
}
_time.advance(R);
