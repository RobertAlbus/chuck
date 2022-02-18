Time2 _time;
Time2.setBpm(144);

MidiNotes _notes;

// MidiIn midi;
// MidiMsg msg;
// "Midi Through Port-0" => string midiThrough;
// "Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;
1 => master.gain;

HH808 hats => Gain hatChannel => master;
0.3 => hatChannel.gain;
Kick kick => Gain kickChannel => master;
OscSynthSingle bass => Gain bassChannel => master;
OscSynthSingle lead => Gain leadChannel => master;


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

// HAT PATCH
Std.srand(4896);
hats.randomize();


////
// PATTERNS

0 => float X; // keyOff
1 => float I; // keyOn
2 => float _; // pass

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


////////
// STSQ

StepSequencer stsq_k;
StepSequencer stsq_hh;
StepSequencer stsq_bass;
[kick $ Instrument] @=> stsq_k.instruments;
[hats $ Instrument] @=> stsq_hh.instruments;
[bass $ Instrument] @=> stsq_bass.instruments;

// ASSIGN PATTERNS TO STSQ
kickTriggerPatterns[1] @=> stsq_k.triggerSteps;
hatTriggerPatterns[0] @=> stsq_hh.triggerSteps;
bassTriggerPatterns[1] @=> stsq_bass.triggerSteps;

kickNotePatterns[0] @=> stsq_k.noteSteps;
hatNotePatterns[0] @=> stsq_hh.noteSteps;
bassNotePatterns[1] @=> stsq_bass.noteSteps;


////////
// PLAY

while(true) {
  (now/1::_time.quat) => float currentStep;
  if (currentStep % 1.00 == 0) {
    stsq_hh.play(currentStep $int);
    stsq_k.play(currentStep $int);
    stsq_bass.play(currentStep $int);
  }

  samp=>now;
}
