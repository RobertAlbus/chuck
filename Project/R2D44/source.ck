Time2 _time;
Time2.setBpm(160);

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
0.6 => hatChannel.gain;
Kick kick => Gain kickChannel => master;
OscSynthSingle bass => Gain bassChannel => master;

// BASS PATCH
"saw" => bass.oscType;
100 => bass.lpfCutoff;
1000 => bass.adsrLpfCutoffAmount;
(0::_time.quat, 1::_time.quat, 0.2, 0::samp) => bass.adsrLpfCutoff.set;


Std.srand(4896);
hats.randomize();

// set up step sequencer
0 => float X; // keyOff
1 => float I; // keyOn
2 => float _; // pass
StepSequencer stsq_k;
StepSequencer stsq_hh;
StepSequencer stsq_bass;
[kick $ Instrument] @=> stsq_k.instruments;
[hats $ Instrument] @=> stsq_hh.instruments;
[bass $ Instrument] @=> stsq_bass.instruments;

[I,_,_,_,I,_,_,_,I,_,_,_,I,_,I,_] @=> stsq_k.triggerSteps;
[X,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_] @=> stsq_hh.triggerSteps;
[_notes.F4 $float] @=> stsq_k.noteSteps;
[1.0] @=> stsq_hh.noteSteps;

_notes.D2 => float S;
_notes.F2 => float T;
_notes.G2 => float U;
_notes.Gs2 => float V;
[I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,X] @=> stsq_bass.triggerSteps;
[T,U,V,T,U,V,S,T,U,V,T,U,V,S,S,S] @=> stsq_bass.noteSteps;


while(true) {
  (now/1::_time.quat) => float currentStep;
  if (currentStep % 1.00 == 0) {
    stsq_hh.play(currentStep $int);
    stsq_k.play(currentStep $int);
    stsq_bass.play(currentStep $int);
  }

  samp=>now;
}
