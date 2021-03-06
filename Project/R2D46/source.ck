Time2 _time;
Time2.setBpm(144);

MidiNotes _notes;
MidiScales _scales;
MidiChords _chords;

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;
0.8 => master.gain;

HH808 hats => Gain hatChannel => master;
0.3 => hatChannel.gain;
Kick kick => Gain kickChannel => master;
OscSynthSingle bass => Gain bassChannel => master;
OscSynthSingle lead => Gain leadChannel => master;
[
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle
] @=> OscSynthSingle chordVoices[];

Gain chordSum => Gain chordChannel => master;
for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => chordSum;
}
1.0 / chordVoices.size() => chordSum.gain;
0.4 => chordChannel.gain;

////////
// PATCHES

// PLUCK PATCH
fun void setPluckPatch(OscSynthSingle oscSynth){
  "saw" => oscSynth.oscType;
  100 => oscSynth.lpfCutoff;
  1000 => oscSynth.adsrLpfCutoffAmount;
  (0::_time.quat, 1::_time.quat, 0.2, 0::samp) => oscSynth.adsrLpfCutoff.set;
  2.1 => oscSynth.lpf.Q;
}

bass => setPluckPatch;
lead => setPluckPatch;

// PAD PATCH
fun void setPadPatch(OscSynthSingle oscSynth){
  "saw" => oscSynth.oscType;
  500 => oscSynth.lpfCutoff;
  500 => oscSynth.adsrLpfCutoffAmount;
  (2::_time.quat, 12::_time.beat, 0, 0::_time.beat) => oscSynth.adsrLpfCutoff.set;
  (0::_time.quat, 12::_time.beat, 0, 0::_time.beat) => oscSynth.adsrAmp.set;
  2.1 => oscSynth.lpf.Q;
}

for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => setPadPatch;
}

// HAT PATCH
Std.srand(4896);
hats.randomize();


////
// PATTERNS

0 => float X; // keyOff
1 => float I; // keyOn
2 => float _; // pass

// all exist in F melodic minor
_notes.D2 => float s;
_notes.F2 => float t;
_notes.G2 => float u;
_notes.Gs2 => float v;
_notes.E3 => float R;
_notes.D4 => float S;
_notes.F3 => float T;
_notes.G3 => float U;
_notes.Gs3 => float V;

// KICK
[
  [I,_,_,_,I,_,_,_,I,_,_,_,I,_,I,_],
  [I,_,_,I,_,_,I,_,I,_,_,I,_,_,I,_] 
] @=> float kickTriggerPatterns[][];

[
  [_notes.F4]
] @=> float kickNotePatterns[][];

// HAT
[
  [X,_,I,X,_,_,I,X,_,_,I,X,_,_,I,_],
  [X,_,I,_,X,_,I,_,X,_,I,_,X,_,I,_],
  [X,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_]
] @=> float hatTriggerPatterns[][];

[
  [1.0]
] @=> float hatNotePatterns[][];

// BASS
[
  [I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,X],
  [I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,_,I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,X]
] @=> float bassTriggerPatterns[][];

[
  [t,u,v,t,u,v,s,t,u,v,t,u,v,s,s,s],
  [t,u,v,T,u,v,S,t,u,v,T,u,t,R,S,S]
] @=> float bassNotePatterns[][];

// CHORDS
[_notes.G4,_notes.As4,_notes.D4,_notes.F5] @=> float Gm7[];
[_notes.F4,_notes.Gs4,_notes.C4,_notes.Ds4] @=> float Fm7[];
float chordProgression[0][0];
chordProgression 
  << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
  << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
  << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
  << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7        << Fm7;

for (0 => int i; i < chordProgression[0].size(); i++) {
  12.0 -=> chordProgression[0][i];
}

[
  [X,_,_,_,_,_,I,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
] @=> float chordTriggerPatterns[][];


////////
// STSQ

StepSequencer stsq_k;
StepSequencer stsq_hh;
StepSequencer stsq_bass;
[kick $ Instrument] @=> stsq_k.instruments;
[hats $ Instrument] @=> stsq_hh.instruments;
[bass $ Instrument] @=> stsq_bass.instruments;

StepSequencer stsq_chord[0];
stsq_chord << new StepSequencer << new StepSequencer << new StepSequencer << new StepSequencer;

for(0 => int i; i < stsq_chord.size(); i++) {
  [chordVoices[i] $ Instrument] @=> stsq_chord[i].instruments;
}

// ASSIGN PATTERNS TO STSQ
kickTriggerPatterns[0] @=> stsq_k.triggerSteps;
hatTriggerPatterns[0] @=> stsq_hh.triggerSteps;
bassTriggerPatterns[1] @=> stsq_bass.triggerSteps;

kickNotePatterns[0] @=> stsq_k.noteSteps;
hatNotePatterns[0] @=> stsq_hh.noteSteps;
bassNotePatterns[1] @=> stsq_bass.noteSteps;

// chords[] axis change
for (0 => int i; i < chordProgression.size(); i ++) {
  for ( 0 => int j; j < stsq_chord.size(); j++) {
    stsq_chord[j].noteSteps << chordProgression[i][j];
    chordTriggerPatterns[0] @=> stsq_chord[j].triggerSteps;
  }
}


////////
// PLAY

while(true) {
  (now/1::_time.quat) => float currentStep;
  if (currentStep % 1.00 == 0) {
    stsq_hh.play(currentStep $int);
    stsq_k.play(currentStep $int);
    stsq_bass.play(currentStep $int);

    for(0 => int i; i < stsq_chord.size(); i++) {
      stsq_chord[i].play(currentStep $int);
    }
  }

  samp=>now;
}
